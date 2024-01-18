variable "shared_vpc" {
  type = list(object({
    project         = string
    service_project = string
    service_account = string
    subnet          = string
  }))
}
