
module "budget" {
  source = "github.com/XBankGCPOrg/gcp-lz-modules//budget/?ref=f679c67a597250f5488659d2d3d37e2301c20112"

  for_each      = { for entry in var.budget_config : entry.display_name => entry }
  budget_config = each.value

}