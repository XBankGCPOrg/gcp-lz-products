
module "budget" {
  source = "github.com/XBankGCPOrg/gcp-lz-modules//budget/?ref=1afce8e3476c3b6e5522d102ba07b3c18caa7d82"

  for_each      = { for entry in var.budget_config : entry.display_name => entry }
  budget_config = each.value

}