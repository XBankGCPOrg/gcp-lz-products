locals {
  control_encrypters = ["serviceAccount:${data.google_storage_project_service_account.control_gcs_account.email_address}"]
}

# Uses organization policy V1 to avoid needing to set quota project during bootstrap
resource "google_project_organization_policy" "iam_disableCrossProjectServiceAccountUsage" {
  project    = module.projects.project_id
  constraint = "iam.disableCrossProjectServiceAccountUsage"
  boolean_policy {
    enforced = false
  }
}

data "google_storage_project_service_account" "control_gcs_account" {
  project = module.projects.project_id

  depends_on = [module.projects]
}

module "control_kms_key" {
  source          = "github.com/XBankGCPOrg/gcp-lz-modules//kms/key?ref=v2"
  name            = module.projects.project_id
  key_ring_name   = module.projects.project_id
  project         = module.projects.project_id
  rotation_period = "7776000s" #key rotation is set to 90 days
  location        = var.location
  encrypters      = local.control_encrypters
  decrypters      = local.control_encrypters

  depends_on = [module.projects]
}

module "individual_state_files" {
  source     = "github.com/XBankGCPOrg/gcp-lz-modules//storage/bucket?ref=v2"
  for_each   = toset([for sa in var.service_accounts.serviceAccounts : sa.tfstateBucketName])
  name       = "bkt-${module.projects.project_id}-${each.value}"
  project    = module.projects.project_id
  location   = var.location
  kms_key_id = module.control_kms_key.key_id

  depends_on = [module.control_kms_key.encrypters, module.control_kms_key.decrypters]
}

module "service_account" {
  source   = "github.com/XBankGCPOrg/gcp-lz-modules//iam/service_account?ref=v2"
  for_each = { for sa in var.service_accounts.serviceAccounts : sa.name => sa }

  name         = "sa-${each.value.name}"
  display_name = each.value.displayName
  description  = each.value.description
  project      = module.projects.project_id
}

resource "google_service_account_iam_member" "sa_service_account_user" {
  for_each           = { for sa in var.service_accounts.serviceAccounts : sa.name => sa }
  service_account_id = module.service_account[each.key].name
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${module.service_account[each.key].email}"
}

resource "google_service_account_iam_member" "sa_service_account_token_creator" {
  for_each           = { for sa in var.service_accounts.serviceAccounts : sa.name => sa }
  service_account_id = module.service_account[each.key].name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:${module.service_account[each.key].email}"
}

resource "google_storage_bucket_iam_member" "sa_service_account_state_individual_storage_admin" {
  for_each = { for sa in var.service_accounts.serviceAccounts : sa.name => sa }
  bucket   = module.individual_state_files[each.value.tfstateBucketName].name
  role     = "roles/storage.admin"
  member   = "serviceAccount:${module.service_account[each.key].email}"
}

resource "google_billing_account_iam_member" "binding" {
  for_each           = { for sa in var.service_accounts.serviceAccounts : sa.name => sa if sa.billingUser }
  billing_account_id = var.billing_account
  role               = "roles/billing.user"
  member             = "serviceAccount:${module.service_account[each.key].email}"
}

resource "google_billing_account_iam_member" "binding_admin" {
  for_each           = { for sa in var.service_accounts.serviceAccounts : sa.name => sa if sa.billingAdmin }
  billing_account_id = var.billing_account
  role               = "roles/billing.admin"
  member             = "serviceAccount:${module.service_account[each.key].email}"
}