locals {
  guardrails = {
    org-policy = {
      name        = "org-policy"
      log_topic   = "org-policy"
      alert_topic = "guardrails-alert"
    }
  }
  log_sinks = {
    org-policy = {
      name   = "org-policy"
      topic  = "org-policy"
      filter = <<EOT
          ( ( protoPayload.serviceName=("orgpolicy.googleapis.com") AND
              protoPayload.methodName=(
              "google.cloud.orgpolicy.v2.OrgPolicy.CreatePolicy" OR
              "google.cloud.orgpolicy.v2.OrgPolicy.UpdatePolicy" OR
              "google.cloud.orgpolicy.v2.OrgPolicy.DeletePolicy"
          )
          ) OR
          ( protoPayload.serviceName=("cloudresourcemanager.googleapis.com") AND
              protoPayload.methodName=(
              "SetOrgPolicy" OR
              "ClearOrgPolicy"
              )
          ) 
          ) AND
          severity != ("ERROR")
      EOT
    }
  }

  guardrails_services = ["pubsub.googleapis.com", "artifactregistry.googleapis.com", "cloudfunctions.googleapis.com"]
  other_guardrails_encrypters = [
    "serviceAccount:${data.google_storage_project_service_account.guardrails_gcs_account.email_address}"
  ]
  guardrails_encrypters = concat([for identity in module.guardrails_service_identity : "serviceAccount:${identity.email}"], local.other_guardrails_encrypters)
}

module "guardrails_service_identity" {
  source   = "github.com/XBankGCPOrg/gcp-lz-modules//resources/service_identity?ref=main"
  for_each = toset(local.guardrails_services)
  project  = module.projects[var.project_guardrails].project_id
  service  = each.value
}

data "google_storage_project_service_account" "guardrails_gcs_account" {
  project = module.projects[var.project_guardrails].project_id
}

module "guardrails_kms_key" {
  source          = "github.com/XBankGCPOrg/gcp-lz-modules//kms/key?ref=main"
  name            = var.test_flag ? "${module.projects[var.project_guardrails].project_id}-test" : module.projects[var.project_guardrails].project_id
  key_ring_name   = var.test_flag ? "${module.projects[var.project_guardrails].project_id}-test" : module.projects[var.project_guardrails].project_id
  project         = module.projects[var.project_guardrails].project_id
  location        = var.location
  rotation_period = "7776000s" #key rotation is set to 90 days
  encrypters      = local.guardrails_encrypters
  decrypters      = local.guardrails_encrypters
}

module "guardrails_storage" {
  source              = "github.com/XBankGCPOrg/gcp-lz-modules//storage/bucket?ref=main"
  name                = "bkt-${module.projects[var.project_guardrails].project_id}-guardrails"
  project             = module.projects[var.project_guardrails].project_id
  location            = var.location
  kms_key_id          = module.guardrails_kms_key.key_id
  data_classification = "code"

  depends_on = [module.guardrails_kms_key.encrypters]
}

data "archive_file" "guardrails_source" {
  type        = "zip"
  source_dir  = abspath("${path.module}/src/guardrails")
  output_path = "${path.module}/guardrails.zip"
}

resource "google_storage_bucket_object" "guardrails" {
  name   = format("%s_%s%s", "guardrail", data.archive_file.guardrails_source.output_md5, ".zip")
  bucket = module.guardrails_storage.name
  source = data.archive_file.guardrails_source.output_path
}

module "guardrails_artifact_registry" {
  source = "github.com/XBankGCPOrg/gcp-lz-modules//devops/artifact_registry?ref=main"

  name        = "ar-${module.projects[var.project_guardrails].project_id}-guardrails"
  description = "Docker containers for guardrail cloudfunctions"
  project     = module.projects[var.project_guardrails].project_id
  location    = var.location

  kms_key_id = module.guardrails_kms_key.key_id

  depends_on = [module.guardrails_kms_key.encrypters]
}

module "guardrails_log_sink" {
  source           = "github.com/XBankGCPOrg/gcp-lz-modules//log_sink?ref=main"
  for_each         = local.log_sinks
  name             = var.test_flag ? "ls-b-guardrail-${each.value.name}-test" : "ls-b-guardrail-${each.value.name}"
  org_id           = local.organization_id
  include_children = true
  destination      = "pubsub.googleapis.com/projects/${module.projects[var.project_guardrails].project_id}/topics/${module.guardrails_pubsub_log_topic[each.value.topic].name}"
  filter           = each.value.filter
}

module "guardrails_pubsub_log_topic" {
  source     = "github.com/XBankGCPOrg/gcp-lz-modules//pubsub/topic?ref=main"
  for_each   = local.guardrails
  name       = "ps-${module.projects[var.project_guardrails].project_id}-guardrail-${each.value.log_topic}"
  project    = module.projects[var.project_guardrails].project_id
  kms_key_id = module.guardrails_kms_key.key_id

  depends_on = [module.guardrails_kms_key.encrypters]
}

resource "google_pubsub_topic_iam_member" "guardrails_pubsub_sink_member" {
  for_each = local.log_sinks
  project  = module.projects[var.project_guardrails].project_id
  topic    = "ps-${module.projects[var.project_guardrails].project_id}-guardrail-${each.value.topic}"
  role     = "roles/pubsub.publisher"
  member   = module.guardrails_log_sink[each.key].writer_identity
}

module "service_account" {
  source   = "github.com/XBankGCPOrg/gcp-lz-modules//iam/service_account?ref=main"
  for_each = local.guardrails

  name         = "sa-guardrail-${each.value.name}"
  display_name = "Guardrail Service Account - ${each.value.name}"
  description  = "Service Account for ${each.value.name} guardrail"
  project      = module.projects[var.project_guardrails].project_id
}

resource "time_sleep" "wait_30_seconds" {
  depends_on = [module.guardrails_artifact_registry, module.guardrails_service_identity, module.guardrails_kms_key.encrypters]

  create_duration = "30s"
}

module "guardrails_cloudfunction" {
  source   = "github.com/XBankGCPOrg/gcp-lz-modules//compute/cloudfunction?ref=main"
  for_each = local.guardrails
  project  = module.projects[var.project_guardrails].project_id
  location = var.location

  name        = "cfn-${module.projects[var.project_guardrails].project_id}-guardrail-${each.value.name}"
  description = "Guardrail for ${each.value.name}"
  runtime     = "python311"

  service_account_email = module.service_account[each.value.name].email

  source_archive_bucket = module.guardrails_storage.name
  source_archive_object = google_storage_bucket_object.guardrails.name

  pubsub_topic_name = module.guardrails_pubsub_log_topic[each.value.log_topic].name
  entry_point       = "event_handler"
  kms_key_id        = module.guardrails_kms_key.key_id
  docker_repository = module.guardrails_artifact_registry.id

  //  vpc_connector = TBD

  environment_variables = {}

  depends_on = [module.guardrails_kms_key.encrypters, module.guardrails_artifact_registry, module.guardrails_service_identity, time_sleep.wait_30_seconds]
}

module "guardrail_pubsub_topic_alerts" {
  source     = "github.com/XBankGCPOrg/gcp-lz-modules//pubsub/topic?ref=main"
  name       = "ps-${module.projects[var.project_guardrails].project_id}-guardrails-alert"
  project    = module.projects[var.project_guardrails].project_id
  kms_key_id = module.guardrails_kms_key.key_id

  depends_on = [module.guardrails_kms_key.encrypters]
}