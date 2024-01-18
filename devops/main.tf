module "organization" {
  source = "github.com/XBankGCPOrg/gcp-lz-modules//resources/organization?ref=v2"

  domain = var.domain
}

module "folders" {
  source = "github.com/XBankGCPOrg/gcp-lz-modules//resources/folder?ref=v2"

  display_name = var.bootstrap_folder_name
  parent       = module.organization.name
}

module "projects" {
  source = "github.com/XBankGCPOrg/gcp-lz-modules//resources/project?ref=v2"

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
  reason       = "Critical seed project as part of the GCP Landing Zone Bootstrap"
}