data "google_organization" "organization" {
  domain = var.domain
}

data "google_cloud_asset_resources_search_all" "projects" {
  provider = google-beta

  scope = "organizations/${data.google_organization.organization.org_id}"
  asset_types = [
    "cloudresourcemanager.googleapis.com/Project"
  ]
  query = "state:ACTIVE"
}

locals {
  regex_name = "\\/\\/cloudresourcemanager\\.googleapis\\.com\\/(?P<type>.*)\\/(?P<name>.*)"
}