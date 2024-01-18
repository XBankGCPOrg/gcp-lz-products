variable "cluster_config" {
  description = "GKE Autopilot cluster configuration"
  type = object({
    name                       = string
    region                     = string
    network                    = string
    subnetwork                 = string
    ip_range_pods              = string
    ip_range_services          = string
    project_id                 = string
    master_ipv4_cidr           = string
    master_authorized_networks = string
    create_service_account     = bool
    network_project_id         = string
    #    local.region                  = string 
    service_account = string
    #    cluster_secondary_range_name  = string
    #    services_secondary_range_name = string
    #    security_group                = string
    resource_labels = map(string)
    machine_type    = string
  })

  validation {
    condition     = length(var.cluster_config[*].name) == length(distinct(var.cluster_config[*].name))
    error_message = "GKE standard name already exists/duplicated."
  }
}
