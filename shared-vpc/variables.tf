variable "shared_vpc" {
  type = list(object({
    host_project    = string
    service_project = string
    service_account = string
    subnet          = list(string)
  }))
}