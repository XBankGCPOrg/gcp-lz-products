# locals {
#   subnets = yamldecode(file("${path.module}/subnet.yaml")).subnets

# }
# module "vpc" {
#   source = "../../gcp-lz-modules/network/vpc"
#   # vpc_list   = var.network_config.vpcs

# }


module "createvpcs" {
  source = "github.com/XBankGCPOrg/gcp-lz-modules//network/vpc?ref=v2"
  #  source = "../../gcp-lz-modules/network/vpc"
  vpc_list = var.network_config.vpcs
}

module "createsubnets" {
  source = "github.com/XBankGCPOrg/gcp-lz-modules//network/subnets?ref=v2"
  # source = "../../gcp-lz-modules/network/subnets"
  subnets    = var.network_config.subnets
  depends_on = [module.createvpcs]
}

# # VPC Peering created for local and peering network. Initiator creates this module block and connectivity is done for both sides.
# module "vpc_n_shared_core_peering_to_mgmt_0" {
#   source = "../../modules/vpc-peering"

#   vpc_name                     = module.vpc_n_shared_core.vpc_name
#   vpc_peering_name             = "vpc-peering-${var.environment_code}-${var.vpc_name}-core-0-to-mgmt-0"
#   local_network                = module.vpc_n_shared_core.vpc_network.self_link
#   peering_network              = "https://www.googleapis.com/compute/v1/projects/prj-c-networking/global/networks/vpc-shared-mgmt-0"
#   export_local_custom_routes   = true
#   export_peering_custom_routes = true
# }
