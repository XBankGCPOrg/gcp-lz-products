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

module "cloud-dns" {
  source   = "github.com/XBankGCPOrg/gcp-lz-modules//cloud-dns/private?ref=v2"
  dns_zone = var.dns_zone
}
