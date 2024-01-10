variable "shared_vpc" {
  type = list(object({
    project         = string
    service_project = string
  }))
}