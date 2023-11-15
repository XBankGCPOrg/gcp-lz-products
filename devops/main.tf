module "organization" {
  source = "github.com/XBankGCPOrg/gcp-lz-modules//resources/organization?ref=main"

  domain = var.domain
}

module "folders" {
  source = "github.com/XBankGCPOrg/gcp-lz-modules//resources/folder?ref=main"

  display_name = var.bootstrap_folder_name
  parent       = module.organization.name
}

module "projects" {
  source = "github.com/XBankGCPOrg/gcp-lz-modules//resources/project?ref=main"

  name            = var.seed_project_name
  folder          = module.folders.name
  services        = var.enable_apis
  billing_account = var.billing_account
  labels          = var.labels
}


resource "google_resource_manager_lien" "lien" {
  parent       = "projects/${module.projects.number}"
  restrictions = ["resourcemanager.projects.delete"]
  origin       = "machine-readable-explanation"
  reason       = "Critical seed project as part of the GCP Landing-zone Bootstrap"
}

resource "google_folder_iam_audit_config" "folder_config" {

  folder  = module.folders.name
  service = "allServices"
  audit_log_config {
    log_type = "ADMIN_READ"
  }

  audit_log_config {
    log_type = "DATA_READ"
  }

  audit_log_config {
    log_type = "DATA_WRITE"
  }
}


resource "google_project_iam_audit_config" "project_config" {
  project = module.projects.project_id
  service = "allServices"
  audit_log_config {
    log_type = "ADMIN_READ"
  }

  audit_log_config {
    log_type = "DATA_READ"
  }

  audit_log_config {
    log_type = "DATA_WRITE"
  }
}
