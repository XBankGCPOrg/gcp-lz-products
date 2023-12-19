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

variable "foundation_hierarchy" {
  description = "Foundation Resource Hierarchy"
  type = object({
    folders = list(object({
      displayName = string
      parent      = string
    }))
    projects = list(object({
      displayName         = string
      parent              = string
      services            = list(string)
      labels              = map(string)
      imported_project_id = optional(string, null)
      lienReason          = optional(string)
      service_identities  = optional(list(string), [])
      service_accounts = optional(list(object({
        name        = string
        displayName = string
        description = string
      })), [])
    }))
  })

  validation {
    condition     = length(var.foundation_hierarchy.folders.*.displayName) == length(distinct(var.foundation_hierarchy.folders.*.displayName)) && length(var.foundation_hierarchy.projects.*.displayName) == length(distinct(var.foundation_hierarchy.projects.*.displayName))
    error_message = "Folder or Project name already exists/duplicated."
  }
}

variable "iam_policy" {
  description = "IAM role binding"
  type = object({
    organizations = list(object({
      name = string
      iamPolicy = optional(object({
        bindings = optional(list(object({
          role    = optional(string)
          members = optional(list(string))
        })), [])
      }), {})
      roles = optional(list(object({
        name                = optional(string)
        title               = optional(string)
        description         = optional(string)
        includedPermissions = optional(list(string))
      })), [])
    }))
    folders = list(object({
      name = string
      iamPolicy = object({
        bindings = list(object({
          role    = string
          members = list(string)
        }))
      })
    }))
    projects = list(object({
      name = string
      iamPolicy = optional(object({
        bindings = optional(list(object({
          role    = optional(string)
          members = optional(list(string))
        })), [])
      }), {})
      roles = optional(list(object({
        name                = optional(string)
        title               = optional(string)
        description         = optional(string)
        includedPermissions = optional(list(string))
      })), [])
    }))
    service_accounts = list(object({
      name = string
      iamPolicy = object({
        bindings = list(object({
          role    = string
          members = list(string)
        }))
      })
    }))
  })

}

variable "org_policy" {
  description = "Organization policies"
  type        = any
}

variable "deny_policies" {
  description = "Deny policies"
  type        = any
}

variable "project_billing" {
  description = "Billing project name"
  type        = string
}

variable "project_guardrails" {
  description = "Security gaurdrail project name"
  type        = string
}

variable "project_logging" {
  description = "Logging project name"
  type        = string
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

variable "test_flag" {
  type    = bool
  default = false
}

variable "budget_config" {
  description = "Configuration for setting GCP budget"
  type = list(object({
    billing_account                  = string
    projects                         = list(string)
    create_budget                    = bool
    display_name                     = string
    credit_types_treatment           = string
    services                         = list(string)
    calendar_period                  = string
    custom_period_start_date         = string
    custom_period_end_date           = string
    alert_spent_percents             = list(number)
    alert_spend_basis                = string
    alert_pubsub_topic               = string
    monitoring_notification_channels = list(string)
    labels                           = map(string)
    budget_amount_sandbox            = string
    budget_amount_default            = string
    currency_code                    = string
    project_prefix                   = optional(string)
  }))
}