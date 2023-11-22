data "google_organization" "organization" {
  domain = var.domain
}

locals {
  organization_id = data.google_organization.organization.org_id
  service_accounts = flatten([for project in var.foundation_hierarchy.projects : [
    for service_account in project.service_accounts : {
      name        = service_account.name
      displayName = service_account.displayName
      description = service_account.description
      project     = project.displayName
    }]
  ])
  service_identities = flatten([for project in var.foundation_hierarchy.projects : [
    for service_identity in project.service_identities : {
      project = project.displayName
      service = service_identity
    }
  ]])
  default_services                 = ["storage.googleapis.com", "bigquery.googleapis.com", ]
  default_storage_service_account  = { for entry in local.service_identities : "${entry.service}@${entry.project}" => data.google_storage_project_service_account.account["${entry.service}@${entry.project}"].email_address if contains(["storage.googleapis.com"], entry.service) }
  default_bigquery_service_account = { for entry in local.service_identities : "${entry.service}@${entry.project}" => data.google_bigquery_default_service_account.account["${entry.service}@${entry.project}"].email if contains(["bigquery.googleapis.com"], entry.service) }
  service_identity_service_account = { for entry in local.service_identities : "${entry.service}@${entry.project}" => module.service_identity["${entry.service}@${entry.project}"].email if contains(local.default_services, entry.service) == false }
  combined_service_identity_email  = merge(local.default_storage_service_account, local.default_bigquery_service_account, local.service_identity_service_account)
}

module "organization" {
  source = "github.com/XBankGCPOrg/gcp-lz-modules//resources/organization?ref=main"
  domain = var.domain
}

module "folders" {
  source      = "github.com/XBankGCPOrg/gcp-lz-modules//resources/multi_level_folder?ref=main"
  folder_list = var.foundation_hierarchy.folders
  parent_name = module.organization.name
}

module "projects" {
  source   = "github.com/XBankGCPOrg/gcp-lz-modules//resources/project?ref=main"
  for_each = { for entry in var.foundation_hierarchy.projects : entry.displayName => entry }

  name                = each.value.displayName
  folder              = flatten([for folder in module.folders.folder_id : values(folder) if contains(keys(folder), each.value.parent)]).0
  services            = each.value.services
  billing_account     = try(each.value.billingAccount, var.billing_account)
  labels              = try(each.value.labels, var.labels)
  imported_project_id = each.value.imported_project_id
}

resource "google_resource_manager_lien" "lien" {
  for_each = { for entry in var.foundation_hierarchy.projects : entry.displayName => entry if entry.lienReason != null }
  parent   = "projects/${module.projects[each.key].number}"

  restrictions = ["resourcemanager.projects.delete"]
  origin       = "machine-readable-explanation"
  reason       = each.value.lienReason
}

module "service_accounts" {
  source   = "github.com/XBankGCPOrg/gcp-lz-modules//iam/service_account?ref=main"
  for_each = { for entry in local.service_accounts : "${entry.name}@${entry.project}" => entry }

  name         = each.value.name
  display_name = each.value.displayName
  description  = each.value.description
  project      = module.projects[each.value.project].project_id
}

module "service_identity" {
  source   = "github.com/XBankGCPOrg/gcp-lz-modules//resources/service_identity?ref=main"
  for_each = { for entry in local.service_identities : "${entry.service}@${entry.project}" => entry if contains(local.default_services, entry.service) == false }
  project  = module.projects[each.value.project].project_id
  service  = each.value.service
}

data "google_storage_project_service_account" "account" {
  for_each = { for entry in local.service_identities : "${entry.service}@${entry.project}" => entry if contains(["storage.googleapis.com"], entry.service) }
  project  = module.projects[each.value.project].project_id
}

data "google_bigquery_default_service_account" "account" {
  for_each = { for entry in local.service_identities : "${entry.service}@${entry.project}" => entry if contains(["bigquery.googleapis.com"], entry.service) }
  project  = module.projects[each.value.project].project_id
}