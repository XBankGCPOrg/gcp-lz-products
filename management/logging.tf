locals {
  log_filter = <<-EOF
    logName: /logs/cloudaudit.googleapis.com%2Factivitiy OR
    logName: /logs/cloudaudit.googleapis.com%2Fsystem_event OR
    logName: /logs/cloudaudit.googleapis.com%2Fdata_access OR
    logName: /logs/cloudaudit.googleapis.com%2Fpolicy OR
    logName: /logs/cloudaudit.googleapis.com%2Faccess_transparency
  EOF

  logging_services = ["pubsub.googleapis.com", "artifactregistry.googleapis.com"]
  other_logging_encrypters = [
    "serviceAccount:${data.google_storage_project_service_account.logging_gcs_account.email_address}",
    "serviceAccount:bq-${module.projects[var.project_logging].number}@bigquery-encryption.iam.gserviceaccount.com"
  ]
  logging_encrypters = concat([for identity in module.logging_service_identity : "serviceAccount:${identity.email}"], local.other_logging_encrypters)
}

module "logging_service_identity_for_bigquerry" {
  source  = "github.com/XBankGCPOrg/gcp-lz-modules//resources/service_identity?ref=main"
  project = module.projects[var.project_logging].project_id
  service = "bigquery.googleapis.com"
}

module "logging_service_identity" {
  source     = "github.com/XBankGCPOrg/gcp-lz-modules//resources/service_identity?ref=main"
  for_each   = toset(local.logging_services)
  project    = module.projects[var.project_logging].project_id
  service    = each.value
  depends_on = [module.logging_service_identity_for_bigquerry]
}

data "google_storage_project_service_account" "logging_gcs_account" {
  project = module.projects[var.project_logging].project_id
}

module "logging_kms_key" {
  source          = "github.com/XBankGCPOrg/gcp-lz-modules//kms/key?ref=main"
  name            = module.projects[var.project_logging].project_id
  key_ring_name   = module.projects[var.project_logging].project_id
  project         = module.projects[var.project_logging].project_id
  location        = var.location
  rotation_period = "7776000s" #key rotation is set to 90 days
  encrypters      = local.logging_encrypters
  decrypters      = local.logging_encrypters
}

# No filter on this log sink ensures all logs are forwarded to the storage bucket
module "log_sink_all_to_storage" {
  source           = "github.com/XBankGCPOrg/gcp-lz-modules//log_sink?ref=main"
  name             = "ls-b-log-storage"
  org_id           = local.organization_id
  include_children = true
  destination      = "storage.googleapis.com/${module.log_storage.name}"
  filter           = ""
}

module "log_storage" {
  source              = "github.com/XBankGCPOrg/gcp-lz-modules//storage/bucket?ref=main"
  name                = "bkt-${module.projects[var.project_logging].project_id}-log-storage"
  project             = module.projects[var.project_logging].project_id
  location            = var.location
  kms_key_id          = module.logging_kms_key.key_id
  data_classification = "logs"

  depends_on = [module.logging_kms_key.encrypters]
}

resource "google_storage_bucket_iam_member" "storage_sink_member" {
  bucket = module.log_storage.name
  role   = "roles/storage.objectCreator"
  member = module.log_sink_all_to_storage.writer_identity
}

module "log_sink_filtered_to_bigquery" {
  source           = "github.com/XBankGCPOrg/gcp-lz-modules//log_sink?ref=main"
  name             = "ls-b-log-bigquery"
  org_id           = local.organization_id
  include_children = true
  destination      = "bigquery.googleapis.com/projects/${module.projects[var.project_logging].project_id}/datasets/${module.log_bigquery.dataset_id}"
  filter           = local.log_filter

  # bigquery_options = {
  #   use_partitioned_tables = true
  # }
}

module "log_bigquery" {
  source     = "github.com/XBankGCPOrg/gcp-lz-modules//bigquery/dataset?ref=main"
  name       = "bq-${module.projects[var.project_logging].project_id}"
  project    = module.projects[var.project_logging].project_id
  location   = var.location
  kms_key_id = module.logging_kms_key.key_id

  depends_on = [module.logging_kms_key.encrypters]
}

resource "google_project_iam_member" "bigquery_sink_member" {
  project = module.projects[var.project_logging].project_id
  role    = "roles/bigquery.dataEditor"
  member  = module.log_sink_filtered_to_bigquery.writer_identity
}

module "log_sink_filtered_to_pubsub" {
  source           = "github.com/XBankGCPOrg/gcp-lz-modules//log_sink?ref=main"
  name             = "ls-b-log-pubsub"
  org_id           = local.organization_id
  include_children = true
  destination      = "pubsub.googleapis.com/projects/${module.projects[var.project_logging].project_id}/topics/${module.log_pubsub_topic.name}"
  filter           = local.log_filter
}

module "log_pubsub_topic" {
  source     = "github.com/XBankGCPOrg/gcp-lz-modules//pubsub/topic?ref=main"
  name       = "ps-${module.projects[var.project_logging].project_id}-log"
  project    = module.projects[var.project_logging].project_id
  kms_key_id = module.logging_kms_key.key_id

  depends_on = [module.logging_kms_key.encrypters]
}

resource "google_pubsub_topic_iam_member" "pubsub_sink_member" {
  project = module.projects[var.project_logging].project_id
  topic   = module.log_pubsub_topic.name
  role    = "roles/pubsub.publisher"
  member  = module.log_sink_filtered_to_pubsub.writer_identity
}