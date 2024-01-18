locals {

  regex_role = "(?P<type>.*)\\/(?P<name>.*)"

  org_roles = flatten([
    for org in var.iam_policy.organizations : [
      for role in org.roles : {
        name         = role.name
        organization = org.name
        title        = role.title
        description  = role.description
        permissions  = role.includedPermissions
      }
    ]
  ])

  project_roles = flatten([
    for project in var.iam_policy.projects : [
      for role in project.roles : {
        name        = split("::", role.name)[0]
        project     = split("::", role.name)[1]
        title       = role.title
        description = role.description
        permissions = role.includedPermissions
      }
    ]
  ])

  organization_bindings = flatten([
    for organization in var.iam_policy.organizations : [
      for binding in organization.iamPolicy.bindings : [
        for member in binding.members : [
          for role in binding.roles : {
            org_id = organization.name
            role   = role
            member = member
          }
        ]
      ]
    ]
  ])

  # Need to add code to cope with missing folders object
  folder_bindings = flatten([
    for folder in var.iam_policy.folders : [
      for binding in folder.iamPolicy.bindings : [
        for member in binding.members : [
          for role in binding.roles : {
            folder_id = split("::", member)[1]
            role      = role
            member    = split("::", member)[0]
          }
        ]
      ]
    ]
  ])

  # Need to add code to cope with missing projects object
  project_bindings = flatten([
    for project in var.iam_policy.projects : [
      for binding in project.iamPolicy.bindings : [
        for member in binding.members : [
          for role in binding.roles : {
            project_id = split("::", member)[1]
            role       = role
            member     = split("::", member)[0]
          }
        ]
      ]
    ]
  ])

  service_account_bindings = flatten([
    for service_account in var.iam_policy.serviceAccounts : [
      for binding in service_account.iamPolicy.bindings : [
        for member in binding.members : [
          for role in binding.roles : {
            name   = service_account.name
            role   = role
            member = member
          }
        ]
      ]
    ]
  ])
}

resource "google_organization_iam_custom_role" "organization" {
  for_each = { for role in local.org_roles : role.name => role }

  role_id     = each.value.name
  org_id      = module.organization.org_id
  title       = each.value.title
  description = each.value.description
  permissions = each.value.permissions
}

resource "google_project_iam_custom_role" "project" {
  for_each = { for role in local.project_roles : role.name => role }

  role_id     = each.value.name
  project     = module.projects[each.value.project].project_id
  title       = each.value.title
  description = each.value.description
  permissions = each.value.permissions
}

resource "google_organization_iam_member" "organization" {
  for_each = { for binding in local.organization_bindings : "${binding.org_id}/${binding.role}/${binding.member}" => binding }

  org_id = module.organization.org_id
  role   = regex(local.regex_role, each.value.role).type == "roles" ? each.value.role : google_organization_iam_custom_role.organization[regex(local.regex_role, each.value.role).name].name
  member = strcontains(each.value.member, "=>") ? startswith(each.value.member, "serviceAccount") ? "serviceAccount:${module.service_accounts[split("=>", each.value.member)[1]].email}" : "serviceAccount:${local.combined_service_identity_email[split("=>", each.value.member)[1]]}" : each.value.member
}

resource "google_folder_iam_member" "folder" {
  for_each = { for binding in local.folder_bindings : "${binding.folder_id}/${binding.role}/${binding.member}" => binding }

  folder = flatten([for folder in module.folders.folder_id : values(folder) if contains(keys(folder), each.value.folder_id)])[0]
  role   = regex(local.regex_role, each.value.role).type == "roles" ? each.value.role : google_organization_iam_custom_role.organization[regex(local.regex_role, each.value.role).name].name
  member = strcontains(each.value.member, "=>") ? startswith(each.value.member, "serviceAccount") ? "serviceAccount:${module.service_accounts[split("=>", each.value.member)[1]].email}" : "serviceAccount:${local.combined_service_identity_email[split("=>", each.value.member)[1]]}" : each.value.member
}

resource "google_project_iam_member" "project" {
  for_each = { for binding in local.project_bindings : "${binding.project_id}/${binding.role}/${binding.member}" => binding }

  project = module.projects[each.value.project_id].project_id
  role    = regex(local.regex_role, each.value.role).type == "roles" ? each.value.role : regex(local.regex_role, each.value.role).type == "organization" ? google_organization_iam_custom_role.organization[regex(local.regex_role, each.value.role).name].name : google_project_iam_custom_role.project[regex(local.regex_role, each.value.role).name].name
  member  = strcontains(each.value.member, "=>") ? startswith(each.value.member, "serviceAccount") ? "serviceAccount:${module.service_accounts[split("=>", each.value.member)[1]].email}" : "serviceAccount:${local.combined_service_identity_email[split("=>", each.value.member)[1]]}" : each.value.member
}

resource "google_service_account_iam_member" "service_account" {
  for_each = { for binding in local.service_account_bindings : "${binding.name}/${binding.role}/${binding.member}" => binding }

  service_account_id = startswith(each.value.name, "serviceAccount") ? module.service_accounts[split("=>", each.value.name)[1]].id : each.value.name
  role               = regex(local.regex_role, each.value.role).type == "roles" ? each.value.role : regex(local.regex_role, each.value.role).type == "organization" ? google_organization_iam_custom_role.organization[regex(local.regex_role, each.value.role).name].name : google_project_iam_custom_role.project[regex(local.regex_role, each.value.role).name].name
  member             = strcontains(each.value.member, "=>") ? startswith(each.value.member, "serviceAccount") ? "serviceAccount:${module.service_accounts[split("=>", each.value.member)[1]].email}" : "serviceAccount:${local.combined_service_identity_email[split("=>", each.value.member)[1]]}" : each.value.member
}