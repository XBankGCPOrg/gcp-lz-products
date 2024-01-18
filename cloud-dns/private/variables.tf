variable "dns_zone" {
  description = "Private dns zone information"
  type = object({
    name    = string
    network = string
  })
}
