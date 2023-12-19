module "budget" {
  source   = "github.com/XBankGCPOrg/gcp-lz-modules//budget/?ref=ba138b9f9ebd8a9048ae39e54ddf0b82c2cdb707"
  for_each = var.budget_config

  budget_config = each.value

}