variable "domain" {
  type        = string
  description = "Organization name"
}

variable "centralized_kms" {
  type = list(object({
    name                     = string
    project                  = string
    location                 = string
    rotationPeriod           = string
    destroyScheduledDuration = string
    services                 = optional(list(string), [])
    encrypters               = optional(list(string), [])
    decrypters               = optional(list(string), [])
    preventDestroy           = optional(bool, false)
  }))
  description = "Centralized KMS"
}

variable "artifact_registry" {
  type = list(object({
    name        = string
    description = string
    project     = string
    kms = object({
      kmsLocation = string
      kmsProject  = string
    })
    location = string
  }))
  description = "Artifact Registry"
}