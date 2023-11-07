module "vpc" {
  source                          = "../../../gcp-lz-modules/vpc"
  name                            = var.vpc-name
  routing_mode                    = var.routing_mode
  project                         = var.project
  description                     = var.vpc-description
  delete_default_routes_on_create = var.delete_default_routes_on_create

}
module "subnetworks" {
  source        = "../../../gcp-lz-modules/subnetworks"
  project       = var.project
  vpc-name      = module.vpc.network
  subnet-name   = var.subnet-name
  ip_cidr_range = var.ip_cidr_range
  region        = var.region
  purpose       = var.purpose

  description = var.subnet-description
}

module "cloudnat" {
  source                = "../../../gcp-lz-modules/cloudnat"
  router_create         = var.router_create
  name                  = var.cloudnat-name
  region                = var.region
  project               = var.project
  config_source_subnets = var.config_source_subnets
  router_network        = module.vpc.network


}

module "gke" {
  source                  = "../../../gcp-lz-modules/gke/autopilot"
  name                    = var.gke-name
  location                = var.gke-location
  network                 = module.vpc.network
  subnetwork              = module.subnetworks.subnet
  cluster_ipv4_cidr       = var.cluster_ipv4_cidr
  services_ipv4_cidr      = var.services_ipv4_cidr
  enable_private_endpoint = var.enable_private_endpoint
  master_ipv4_cidr        = var.master_ipv4_cidr
  project                 = var.project
}