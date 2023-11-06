module "artifact_registry" {
  source      = "github.com/XBankGCPOrg/gcp-lz-modules//devops/artifact_registry?ref=main"
  for_each    = { for entry in var.artifact_registry : "ar-${entry.project}-${entry.name}" => entry }
  name        = "ar-${[for entry in data.google_cloud_asset_resources_search_all.projects.results : regex(local.regex_name, entry.name).name if entry.display_name == each.value.project].0}-${each.value.name}"
  description = each.value.description
  project     = [for entry in data.google_cloud_asset_resources_search_all.projects.results : regex(local.regex_name, entry.name).name if entry.display_name == each.value.project].0
  location    = each.value.location
  kms_key_id  = "projects/${[for entry in data.google_cloud_asset_resources_search_all.projects.results : regex(local.regex_name, entry.name).name if entry.display_name == each.value.kms.kms_project].0}/locations/${each.value.kms.kms_location}/keyRings/${[for entry in data.google_cloud_asset_resources_search_all.projects.results : regex(local.regex_name, entry.name).name if entry.display_name == each.value.project].0}/cryptoKeys/${[for entry in data.google_cloud_asset_resources_search_all.projects.results : regex(local.regex_name, entry.name).name if entry.display_name == each.value.project].0}"

  depends_on = [module.centralized_kms.encrypters]
}