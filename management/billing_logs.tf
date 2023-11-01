module "billing_dataset" {
  source   = "github.com/XBankGCPOrg/gcp-lz-modules//bigquery/dataset?ref=main"
  name     = "bq_${replace(module.projects[var.project_billing].project_id, "-", "_")}_billing"
  project  = module.projects[var.project_billing].project_id
  location = var.location
}

module "billing_details_dataset" {
  source   = "github.com/XBankGCPOrg/gcp-lz-modules//bigquery/dataset?ref=main"
  name     = "bq_${replace(module.projects[var.project_billing].project_id, "-", "_")}_billing_details"
  project  = module.projects[var.project_billing].project_id
  location = var.location
}

module "pricing_dataset" {
  source   = "github.com/XBankGCPOrg/gcp-lz-modules//bigquery/dataset?ref=main"
  name     = "bq_${replace(module.projects[var.project_billing].project_id, "-", "_")}_pricing"
  project  = module.projects[var.project_billing].project_id
  location = var.location
}
