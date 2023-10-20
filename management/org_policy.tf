locals {

  organization_policies = flatten([
    for policy in var.org_policy.orgPolicy :
    { policy = policy } if try(policy.exists, false) != true
  ])

  #   folder_names = compact([ 
  #     for folder in local.organization.folders : lookup( local.folders, folder.displayName, null ) != null ? folder.displayName : null   
  #   ])

  #   project_names = compact([
  #     for project in local.organization.projects : lookup( local.projects, project.name, null ) != null ? project.name : null
  #   ])

  #   folder_org_policies = flatten([])
}

module "organization_policy" {
  source   = "github.com/XBankGCPOrg/gcp-lz-modules//iam/org_policy?ref=v0.0.1"
  parent   = "organizations/${module.organization.name}"
  policies = local.organization_policies
}

