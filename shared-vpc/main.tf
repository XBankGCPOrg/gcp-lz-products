module "shared-VPC" {
  source          = "github.com/XBankGCPOrg/gcp-lz-modules//shared_vpc?ref=ef4fb7d8ccc15c5ea818d92d353f9a140355400b"
  project_vending = var.project_vending
}