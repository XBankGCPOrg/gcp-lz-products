variable "domain" {
  description = "The domain to bootstrap"
  type        = string
}

variable "billing_account" {
  description = "The billing account to use for all resources"
  type        = string
}

variable "location" {
  description = "The location to deploy resource"
  type        = string
}

variable "authorized_repositories" {
  type        = map(string)
  description = "Repository information. eg: your_org/your_repository"
}

variable "labels" {
  description = "Labels to apply to all foundation projects"
  type        = map(string)
  default = {
    environment      = "bootstrap"
    application_name = "seed-bootstrap"
    env_code         = "b"
    # business-owner            = "tonstand"
    # finance-approver          = "afins"
    # hfm-entity                = "gb4581"
    # pid                       = "245924"
    # primary-technical-contact = "davbutla"
    # project-code              = "245924"
  }
}

variable "environment" {
  description = "Environment specific settings"
  type        = map(string)
  default     = {}
}
