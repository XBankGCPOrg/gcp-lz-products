variable "cluster_config" {
  description = "GKE Autopilot cluster configuration"
  type = object({
    name                          = string
    location                      = string
    network                       = string
    subnetwork                    = string
    cluster_ipv4_cidr             = string
    services_ipv4_cidr            = string
    project                       = string
    master_ipv4_cidr              = string
    master_authorized_networks    = string
    create_service_account        = bool
    service_account               = string
    cluster_secondary_range_name  = string
    services_secondary_range_name = string
    security_group                = string
    resource_labels               = map(string)
  })

  validation {
    condition     = length(var.cluster_config[*].name) == length(distinct(var.cluster_config[*].name))
    error_message = "GKE autopilot name already exists/duplicated."
  }
}