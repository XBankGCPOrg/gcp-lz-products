variable "vm_config" {
  description = "Bastion host for GKE"
  type = object({
    name       = string
    location   = string
    network    = string
    subnetwork = string
    #    create_service_account        = bool
    email   = string
    project = string
    zone    = string
    tag     = string
  })

  validation {
    condition     = length(var.vm_config[*].name) == length(distinct(var.vm_config[*].name))
    error_message = "Bastion Host name already exists/duplicated."
  }
}
