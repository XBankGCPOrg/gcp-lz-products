module "ip" {
  source = "github.com/XBankGCPOrg/gcp-lz-modules//network/ip-address?ref=v2"
  #source        = "../../gcp-lz-modules/network/ip-address"
  depends_on    = [module.createsubnets]
  for_each      = { for entry in var.ip_address : entry.name => entry }
  name          = each.value.name
  project_id    = each.value.projectId
  region        = each.value.region
  address       = each.value.address
  global        = each.value.global
  subnetwork    = each.value.subnetwork
  network       = each.value.network
  address_type  = each.value.addressType
  purpose       = each.value.purpose
  network_tier  = each.value.networkTier
  prefix_length = each.value.prefixLength
  ip_version    = each.value.ipVersion
}

module "svc-net-peer" {
  source = "github.com/XBankGCPOrg/gcp-lz-modules//network/service-networking?ref=v2"
  #source                  = "../../gcp-lz-modules/network/service-networking"
  depends_on              = [module.ip]
  for_each                = { for entry in var.service_networking_peering : entry.network => entry }
  network                 = each.value.network
  reserved_peering_ranges = each.value.reservedPeeringRanges
  project_id              = each.value.projectId
  import_custom_routes    = each.value.importCustomRoutes
  export_custom_routes    = each.value.exportCustomRoutes
}