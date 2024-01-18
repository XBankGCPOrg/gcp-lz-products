module "shared-VPC" {
  source     = "github.com/XBankGCPOrg/gcp-lz-modules//shared_vpc?ref=16792c0a51ad2097f66f6d1582b7db771da6d328"
  for_each   = { for entry in var.shared_vpc : entry.service_project => entry }
  shared_vpc = each.value
}