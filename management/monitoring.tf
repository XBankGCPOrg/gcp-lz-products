
module "monitoring" {
  source = "github.com/XBankGCPOrg/gcp-lz-modules//monitoring/?ref=9784267f6e832e1a88561108b5975bb43c005111"

  for_each          = { for entry in var.monitoring_config : entry.project_id => entry }
  monitoring_config = each.value

}