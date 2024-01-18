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

module "gke-standard" {
  source = "github.com/XBankGCPOrg/gcp-lz-modules//gke/gke-standard?ref=v2"
  # source         = "../../../gcp-lz-modules/gke/gke-autopilot"
  cluster_config = var.cluster_config
}
