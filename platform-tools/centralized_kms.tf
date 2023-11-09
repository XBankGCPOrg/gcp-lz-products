module "centralized_kms" {
  source                     = "github.com/XBankGCPOrg/gcp-lz-modules//kms/key?ref=main"
  for_each                   = { for entry in var.centralized_kms : entry.name => entry }
  name                       = [for entry in local.project_id : regex(local.regex_name, entry.name).name if entry.display_name == each.value.name].0
  key_ring_name              = [for entry in local.project_id : regex(local.regex_name, entry.name).name if entry.display_name == each.value.name].0
  project                    = [for entry in local.project_id : regex(local.regex_name, entry.name).name if entry.display_name == each.value.project].0
  location                   = each.value.location
  rotation_period            = each.value.rotation_period
  destroy_scheduled_duration = each.value.destroy_scheduled_duration
  services                   = each.value.services
  encrypters                 = each.value.encrypters
  decrypters                 = each.value.decrypters
}