
module "budget" {
  source = "github.com/XBankGCPOrg/gcp-lz-modules//budget/?ref=1f3b765cc16c19b32a26c7682070f49d24a6c47c"

  for_each      = { for entry in var.budget_config : entry.display_name => entry }
  budget_config = each.value

}