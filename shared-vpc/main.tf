terraform {
  required_version = ">= 1.5"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.7.0"
    }
  }
}
module "shared-VPC" {
  source     = "github.com/XBankGCPOrg/gcp-lz-modules//shared_vpc?ref=v2"
  for_each   = { for entry in var.shared_vpc : entry.service_project => entry }
  shared_vpc = each.value
}
