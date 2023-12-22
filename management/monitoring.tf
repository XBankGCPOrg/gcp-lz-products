
module "monitoring" {
  source = "github.com/XBankGCPOrg/gcp-lz-modules//monitoring/?ref=a6c3737c54665b45808006f101b9ef525b7cc268"

  for_each          = { for entry in var.monitoring_config : entry.project_id => entry }
  monitoring_config = each.value

}