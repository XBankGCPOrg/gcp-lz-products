variable "network_config" {
  description = "VPC and all subnets inside the VPC"
  type = object({
    vpcs = list(object({
      vpcName               = string
      project               = string
      autoCreateSubnetworks = optional(bool)
      routingMode           = optional(string)
    }))
    subnets = list(object({
      subnetName          = string
      vpcName             = string
      project             = string
      subnetIPRange       = string
      subnetRegion        = string
      description         = string
      privateGoogleAccess = bool
      purpose             = optional(string)
      secondarySubnets = optional(list(object({
        secondaryIPRangeName = optional(string)
        secondaryIPCIDRRange = optional(string)
      })))
      logConfig = optional(object({
        aggregationInterval = optional(string)
        flowSampling        = optional(number)
        metadata            = optional(string)
      }))
    }))
  })

  validation {
    condition     = length(var.network_config.vpcs[*].vpcName) == length(distinct(var.network_config.vpcs[*].vpcName)) && length(var.network_config.subnets[*].subnetName) == length(distinct(var.network_config.subnets[*].subnetName))
    error_message = "VPC and/or subnet name already exists/duplicated."
  }
}

variable "router_config" {
  description = "Router configurations"
  type = list(object({
    routerName  = string
    projectId   = string
    region      = string
    network     = string
    description = optional(string, null)
    bgp = optional(object({
      asn               = string
      advertise_mode    = optional(string, "CUSTOM")
      advertised_groups = optional(list(string))
      advertised_ip_ranges = optional(list(object({
        range       = string
        description = optional(string)
      })), [])
      keepalive_interval = optional(number)
    }), null)
    interconnectConfig = list(object({
      interconnectName       = string
      interconnect           = optional(string)
      adminEnabled           = optional(string)
      type                   = optional(string, "DEDICATED")
      description            = optional(string)
      bandwidth              = optional(string)
      mtu                    = optional(string, "1440")
      candidateSubnets       = optional(list(string))
      vlanTag8021q           = optional(string)
      edgeAvailabilityDomain = optional(string)
      encryption             = optional(string, "NONE")
      ipsecInternalAddresses = optional(list(string))
    }))
  }))

  default = []

  validation {
    condition     = length(var.router_config[*].routerName) == length(distinct(var.router_config[*].routerName)) && length(var.router_config[*].interconnectConfig[*].interconnectName) == length(distinct(var.router_config[*].interconnectConfig[*].interconnectName))
    error_message = "Router name and Interconnect name should be unique"
  }



}

variable "firewall-rules" {
  description = "Firewall rules"
  type = list(object({
    name                  = string
    projectId             = string
    networkName           = string
    description           = optional(string)
    direction             = optional(string)
    disabled              = optional(bool)
    sourceRanges          = optional(list(string))
    sourceTags            = optional(list(string))
    sourceServiceAccounts = optional(list(string))
    destinationRanges     = optional(list(string))
    targetServiceAccounts = optional(list(string))
    targetTags            = optional(list(string))
    priority              = optional(number)
    logConfig = optional(object({
      metadata = string
    }))
    allow = optional(list(object({
      protocol = string
      ports    = optional(list(string))
    })), [])
    deny = optional(list(object({
      protocol = string
      ports    = optional(list(string))
    })), [])
  }))
}

variable "ip_address" {
  type = list(object({
    name         = string
    projectId    = string
    region       = optional(string, null)
    address      = optional(string, "")
    global       = optional(bool, false)
    subnetwork   = optional(string, null)
    network      = optional(string, null)
    addressType  = optional(string, "INTERNAL")
    purpose      = optional(string, "GCE_ENDPOINT")
    networkTier  = optional(string, "PREMIUM")
    prefixLength = optional(number, null)
    ipVersion    = optional(string, "IPV4")
  }))
  description = "IP Address"
}

variable "service_networking_peering" {
  type = list(object({
    network               = string
    reservedPeeringRanges = list(string)
    projectId             = string
    importCustomRoutes    = optional(bool, false)
    exportCustomRoutes    = optional(bool, false)
  }))
  description = "Service networking peering"
}