
module "monitoring" {
  source = "github.com/XBankGCPOrg/gcp-lz-modules//monitoring/?ref=de122b112bb16a6b1e7becaade306754a801b2fb"

  for_each          = { for entry in var.monitoring_config : entry.project_id => entry }
  monitoring_config = each.value

}