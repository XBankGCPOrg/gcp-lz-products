output "createVPCSelfLink" {
  value = module.createvpcs.vpc_self_links
}

output "VPCName" {
  value = module.createvpcs.vpc_name
}

output "Routers" {
  value = [for k, v in local.routers : module.router[k].router]
}

output "Interconnect-attachment" {
  value = [for entry in local.interconnects : module.interconnect-attachment[entry.interconnectName].attachment]
}