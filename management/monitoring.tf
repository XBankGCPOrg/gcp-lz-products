module "monitoring" {
  source = "github.com/XBankGCPOrg/gcp-lz-modules//monitoring/?ref=v2"

  for_each          = { for entry in var.monitoring_config : entry.project_id => entry }
  monitoring_config = each.value
}

