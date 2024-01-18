locals {
  routers       = { for entry in var.router_config : entry.routerName => entry }
  interconnects = flatten([for k, v in local.routers : [for value in v.interconnectConfig : merge(value, { projectId = v.projectId, region = v.region, router = k })]])
}

module "router" {
  source      = "github.com/XBankGCPOrg/gcp-lz-modules//network/router?ref=v2"
  for_each    = local.routers
  depends_on  = [module.createsubnets]
  name        = each.value.routerName
  network     = each.value.network
  region      = each.value.region
  project     = each.value.projectId
  description = each.value.description
  bgp         = each.value.bgp
}

module "interconnect-attachment" {
  source                   = "github.com/XBankGCPOrg/gcp-lz-modules//network/interconnect-attachment?ref=v2"
  for_each                 = { for entry in local.interconnects : entry.interconnectName => entry }
  depends_on               = [module.router]
  name                     = each.value.interconnectName
  project                  = each.value.projectId
  interconnect             = each.value.interconnect
  admin_enabled            = each.value.adminEnabled
  description              = each.value.description
  region                   = each.value.region
  bandwidth                = each.value.bandwidth
  candidate_subnets        = each.value.candidateSubnets
  mtu                      = each.value.mtu
  vlan_tag8021q            = each.value.vlanTag8021q
  edge_availability_domain = each.value.edgeAvailabilityDomain
  ipsec_internal_addresses = each.value.ipsecInternalAddresses
  encryption               = each.value.encryption
  router                   = each.value.router
  type                     = each.value.type

}