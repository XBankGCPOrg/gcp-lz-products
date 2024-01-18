resource "google_organization_iam_audit_config" "org_config" {
  org_id  = local.organization_id
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

resource "google_folder_iam_audit_config" "folder_config" {
  for_each = toset([for entry in var.foundation_hierarchy.folders : entry.displayName])
  folder   = flatten([for folder in module.folders.folder_id : values(folder) if contains(keys(folder), each.key)])[0]
  service  = "allServices"
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
  for_each = toset([for entry in var.foundation_hierarchy.projects : entry.displayName])
  project  = module.projects[each.key].project_id
  service  = "allServices"
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