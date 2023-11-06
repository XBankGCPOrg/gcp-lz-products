variable "domain" {
  type        = string
  description = "Organization name"
}

variable "centralized_kms" {
  type = list(object({
    name                       = string
    project                    = string
    location                   = string
    rotation_period            = string
    destroy_scheduled_duration = string
    services                   = list(string)
  }))
  description = "Centralized KMS"
}

variable "artifact_registry" {
  type = list(object({
    name        = string
    description = string
    project     = string
    kms = object({
      kms_location = string
      kms_project  = string
    })
    location = string
  }))
  description = "Artifact Registry"
}