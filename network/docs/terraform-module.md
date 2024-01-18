# network

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.0.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 5.0.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_createsubnets"></a> [createsubnets](#module\_createsubnets) | github.com/XBankGCPOrg/gcp-lz-modules//network/subnets | v2 |
| <a name="module_createvpcs"></a> [createvpcs](#module\_createvpcs) | github.com/XBankGCPOrg/gcp-lz-modules//network/vpc | v2 |
| <a name="module_firewall-rules"></a> [firewall-rules](#module\_firewall-rules) | github.com/XBankGCPOrg/gcp-lz-modules//network/firewall-rules | v2 |
| <a name="module_interconnect-attachment"></a> [interconnect-attachment](#module\_interconnect-attachment) | github.com/XBankGCPOrg/gcp-lz-modules//network/interconnect-attachment | v2 |
| <a name="module_ip"></a> [ip](#module\_ip) | github.com/XBankGCPOrg/gcp-lz-modules//network/ip-address | v2 |
| <a name="module_router"></a> [router](#module\_router) | github.com/XBankGCPOrg/gcp-lz-modules//network/router | v2 |
| <a name="module_svc-net-peer"></a> [svc-net-peer](#module\_svc-net-peer) | github.com/XBankGCPOrg/gcp-lz-modules//network/service-networking | v2 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_firewall-rules"></a> [firewall-rules](#input\_firewall-rules) | Firewall rules | <pre>list(object({<br>    name                  = string<br>    projectId             = string<br>    networkName           = string<br>    description           = optional(string)<br>    direction             = optional(string)<br>    disabled              = optional(bool)<br>    sourceRanges          = optional(list(string))<br>    sourceTags            = optional(list(string))<br>    sourceServiceAccounts = optional(list(string))<br>    destinationRanges     = optional(list(string))<br>    targetServiceAccounts = optional(list(string))<br>    targetTags            = optional(list(string))<br>    priority              = optional(number)<br>    logConfig = optional(object({<br>      metadata = string<br>    }))<br>    allow = optional(list(object({<br>      protocol = string<br>      ports    = optional(list(string))<br>    })), [])<br>    deny = optional(list(object({<br>      protocol = string<br>      ports    = optional(list(string))<br>    })), [])<br>  }))</pre> | n/a | yes |
| <a name="input_ip_address"></a> [ip\_address](#input\_ip\_address) | IP Address | <pre>list(object({<br>    name         = string<br>    projectId    = string<br>    region       = optional(string, null)<br>    address      = optional(string, "")<br>    global       = optional(bool, false)<br>    subnetwork   = optional(string, null)<br>    network      = optional(string, null)<br>    addressType  = optional(string, "INTERNAL")<br>    purpose      = optional(string, "GCE_ENDPOINT")<br>    networkTier  = optional(string, "PREMIUM")<br>    prefixLength = optional(number, null)<br>    ipVersion    = optional(string, "IPV4")<br>  }))</pre> | n/a | yes |
| <a name="input_network_config"></a> [network\_config](#input\_network\_config) | VPC and all subnets inside the VPC | <pre>object({<br>    vpcs = list(object({<br>      vpcName               = string<br>      project               = string<br>      autoCreateSubnetworks = optional(bool)<br>      routingMode           = optional(string)<br>    }))<br>    subnets = list(object({<br>      subnetName          = string<br>      vpcName             = string<br>      project             = string<br>      subnetIPRange       = string<br>      subnetRegion        = string<br>      description         = string<br>      privateGoogleAccess = bool<br>      purpose             = optional(string)<br>      secondarySubnets = optional(list(object({<br>        secondaryIPRangeName = optional(string)<br>        secondaryIPCIDRRange = optional(string)<br>      })))<br>      logConfig = optional(object({<br>        aggregationInterval = optional(string)<br>        flowSampling        = optional(number)<br>        metadata            = optional(string)<br>      }))<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_router_config"></a> [router\_config](#input\_router\_config) | Router configurations | <pre>list(object({<br>    routerName  = string<br>    projectId   = string<br>    region      = string<br>    network     = string<br>    description = optional(string, null)<br>    bgp = optional(object({<br>      asn               = string<br>      advertise_mode    = optional(string, "CUSTOM")<br>      advertised_groups = optional(list(string))<br>      advertised_ip_ranges = optional(list(object({<br>        range       = string<br>        description = optional(string)<br>      })), [])<br>      keepalive_interval = optional(number)<br>    }), null)<br>    interconnectConfig = list(object({<br>      interconnectName       = string<br>      interconnect           = optional(string)<br>      adminEnabled           = optional(string)<br>      type                   = optional(string, "DEDICATED")<br>      description            = optional(string)<br>      bandwidth              = optional(string)<br>      mtu                    = optional(string, "1440")<br>      candidateSubnets       = optional(list(string))<br>      vlanTag8021q           = optional(string)<br>      edgeAvailabilityDomain = optional(string)<br>      encryption             = optional(string, "NONE")<br>      ipsecInternalAddresses = optional(list(string))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_service_networking_peering"></a> [service\_networking\_peering](#input\_service\_networking\_peering) | Service networking peering | <pre>list(object({<br>    network               = string<br>    reservedPeeringRanges = list(string)<br>    projectId             = string<br>    importCustomRoutes    = optional(bool, false)<br>    exportCustomRoutes    = optional(bool, false)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_Interconnect-attachment"></a> [Interconnect-attachment](#output\_Interconnect-attachment) | n/a |
| <a name="output_Routers"></a> [Routers](#output\_Routers) | n/a |
| <a name="output_VPCName"></a> [VPCName](#output\_VPCName) | n/a |
| <a name="output_createVPCSelfLink"></a> [createVPCSelfLink](#output\_createVPCSelfLink) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
