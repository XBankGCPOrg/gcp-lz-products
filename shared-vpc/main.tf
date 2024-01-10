module "shared-VPC" {
  source     = "github.com/XBankGCPOrg/gcp-lz-modules//shared_vpc?ref=8174380ed7cf8ee97ac4fae29989045196460a43"
  shared_vpc = var.shared_vpc
}