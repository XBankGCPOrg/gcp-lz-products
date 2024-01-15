module "shared-VPC" {
  source     = "github.com/XBankGCPOrg/gcp-lz-modules//shared_vpc?ref=6b9922e6d2a377133838fd3dbbafce0c122c85d4"
  for_each   = { for entry in var.shared_vpc : entry.service_project => entry }
  shared_vpc = each.value
}