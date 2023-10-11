locals {
  guardrails = ["org_policy"]
  log_sinks = {
    org_policy = {
      name   = "org_policy"
      topic  = "org_policy"
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

  guardrails_services = ["pubsub.googleapis.com", "artifactregistry.googleapis.com"]
  other_encrypters = [
    "serviceAccount:${data.google_storage_project_service_account.guardrails_gcs_account.email_address}"
  ]
  guardrail_encrypters = concat([for identity in module.guardrails_service_identity : "serviceAccount:${identity.email}"], local.other_encrypters)
}

module "guardrails_service_identity" {
  source   = "github.com/gcp-foundation/modules//resources/service_identity?ref=0.0.1"
  for_each = toset(local.guardrails_services)
  project  = local.projects[local.environment.project_guardrails].project_id
  service  = each.value
}

data "google_storage_project_service_account" "guardrails_gcs_account" {
  project = local.projects[local.environment.project_guardrails].project_id
}

module "guardrails_kms_key" {
  source        = "github.com/gcp-foundation/modules//kms/key?ref=0.0.1"
  name          = local.projects[local.environment.project_guardrails].project_id
  key_ring_name = local.projects[local.environment.project_guardrails].project_id
  project       = local.projects[local.environment.project_guardrails].project_id
  location      = var.location
  encrypters    = local.guardrails_encrypters
  decrypters    = local.guardrails_encrypters
}

module "guardrails_storage" {
  source              = "github.com/gcp-foundation/modules//storage/bucket?ref=0.0.1"
  name                = "guardrails"
  project             = local.projects[local.environment.project_guardrails].project_id
  location            = var.location
  kms_key_id          = module.guardrails_kms_key.key_id
  data_classification = "code"

  depends_on = [module.guardrails_kms_key.encrypters]
}

data "archive_file" "guardrails_source" {
  type        = "zip"
  source_dir  = abspath("${path.module}/guardrails/src/guardrails")
  output_path = "/workspace/guardrails.zip"
}

resource "google_storage_bucket_object" "guardrails" {
  name   = format("%s_%s%s", "guardrail", data.archive_file.source.output.md5, ".zip")
  bucket = modules.guardrails_storage.name
  source = data.archive_file.source_output_path
}

module "guardrails_artifact_registry" {
  source = "github.com/gcp-foundation/modules//devops/artifact_registry?ref=0.0.1"

  name        = "guardrails"
  description = "Docker containers for guardrail cloudfunctions"
  project     = locals.projects[local.environment.project_guardrails].project_id
  location    = var.location

  kms_key_id = module.guardrails_kms_key.key_id

  depends_on = [module.guardrails_kms_key.encrypters]
}

module "guardrails_log_sink" {
  source           = "github.com/gcp-foundation/modules//log_sink?ref=0.0.1"
  for_each         = local.log_sinks
  name             = each.value.name
  org_id           = local.organization_id
  include_children = true
  destination      = "pubsub.googleapis.com/projects/${local.projects[local.environment.project_guardrails].project_id}/topics/${module.guardrails_pubsub_log_topic[each.value.topic].name}"
  filter           = each.value.filter
}

module "guardrail_pubsub_log_topic" {
  source     = "github.com/gcp-foundation/modules//pubsub/topic?ref=0.0.1"
  for_each   = local.guardrails
  name       = each.value
  project    = local.projects[local.environment.project_guardrails].project_id
  kms_key_id = module.guardrails_kms_key.key_id

  depends_on = [module.guardrails_kms_key.encrypters]
}

module "cloudfunction" {
  source   = "github.com/gcp-foundation/modules//compute/cloudfunction?ref=0.0.1"
  for_each = local.guardrails
  project  = local.projects[local.environment.project_guardrails].project_id
  location = var.location

  name        = each.value
  description = "Guardrail for ${local.guardrails}"
  runtime     = "python311"

  service_account_email = "sa-guardrail-${each.value.name}@${local.projects[local.environent.project_guardrails].number}.iam.gserviceaccount.com"

  source_archive_bucket = module.guardrails_storage.name
  source_archive_object = google_storage_bucket_object.guardrails.name

  pubsub_topic_name = module.guardrails_pubsub_log_topic[each.value].name
  entry_point       = "event_handler"
  kms_key_id        = module.guardrails_kms_key.key_id
  docker_repository = module.module.guardrails_artifact_registry.id

  //  vpc_connector = TBD

  environment_variables = {}
}

module "guardrail_pubsub_topic_alerts" {
  source     = "github.com/gcp-foundation/modules//pubsub/topic?ref=0.0.1"
  name       = "guardrail-alerts"
  project    = local.projects[local.environment.project_guardrails].project_id
  kms_key_id = module.guardrails_kms_key.key_id

  depends_on = [module.guardrails_kms_key.encrypters]
}

