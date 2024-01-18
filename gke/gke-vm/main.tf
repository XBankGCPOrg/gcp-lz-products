terraform {
  required_version = ">= 1.5"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.7.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 5.7.0"
    }
  }
}

module "vm" {
  source = "github.com/XBankGCPOrg/gcp-lz-modules//vm?ref=v2"
  # source         = "../../../gcp-lz-modules/gke/vm"
  vm_config = var.vm_config
}