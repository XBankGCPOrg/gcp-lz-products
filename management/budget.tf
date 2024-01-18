# Copy and paste the following Terraform code block

module "budget" {
  source        = "github.com/XBankGCPOrg/gcp-lz-modules//budget/?ref=v2"
  for_each      = { for entry in var.budget_config : entry.display_name => entry }
  budget_config = each.value
}
