module "billing_dataset" {
  source   = "github.com/XBankGCPOrg/gcp-lz-modules//bigquery/dataset?ref=main"
  name     = "bq-${module.projects[var.project_billing].project_id}-billing"
  project  = module.projects[var.project_billing].project_id
  location = var.location
}

module "billing_details_dataset" {
  source   = "github.com/XBankGCPOrg/gcp-lz-modules//bigquery/dataset?ref=main"
  name     = "bq-${module.projects[var.project_billing].project_id}-billing-details"
  project  = module.projects[var.project_billing].project_id
  location = var.location
}

module "pricing_dataset" {
  source   = "github.com/XBankGCPOrg/gcp-lz-modules//bigquery/dataset?ref=main"
  name     = "bq-${module.projects[var.project_billing].project_id}-pricing"
  project  = module.projects[var.project_billing].project_id
  location = var.location
}
