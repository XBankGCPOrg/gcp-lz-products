module "shared-VPC" {
  source     = "github.com/XBankGCPOrg/gcp-lz-modules//shared_vpc?ref=769f7203adff0373b4c7d231bb3bdb132ad0fff2"
  for_each   = { for entry in var.shared_vpc : entry.service_project => entry }
  shared_vpc = each.value
}