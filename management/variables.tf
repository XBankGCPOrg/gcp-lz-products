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
    billing_account          = string
    projects                 = list(string)
    create_budget            = bool
    display_name             = string
    credit_types_treatment   = string
    services                 = list(string)
    calendar_period          = string
    custom_period_start_date = string
    custom_period_end_date   = string
    alert_spent_percents     = list(number)
    alert_spend_basis        = string
    # alert_pubsub_topic               = string
    # monitoring_notification_channels = list(string)
    labels                = map(string)
    budget_amount_sandbox = string
    budget_amount_default = string
    currency_code         = string
    project_prefix        = optional(string)
  }))
}

variable "monitoring_config" {
  description = "Configuration for monitoring metrics and alerts"
  type = list(object({
    project_id              = string
    cpu_metric_display_name = string
    cpu_metric_description  = string
    cpu_metric_kind         = string
    cpu_metric_value_type   = string
    cpu_metric_unit         = string
    cpu_metric_metric_type  = string

    memory_display_name = string
    memory_description  = string
    memory_metric_kind  = string
    memory_value_type   = string
    memory_unit         = string
    memory_type         = string

    iops_display_name = string
    iops_description  = string
    iops_metric_kind  = string
    iops_value_type   = string
    iops_unit         = string
    iops_type         = string

    api_requests_display_name = string
    api_requests_description  = string
    api_requests_metric_kind  = string
    api_requests_value_type   = string
    api_requests_unit         = string
    api_requests_type         = string

    bandwidth_display_name       = string
    bandwidth_description        = string
    bandwidth_metric_metric_kind = string
    bandwidth_metric_value_type  = string
    bandwidth_metric_unit        = string
    bandwidth_metric_type        = string

    memory_alert_display_name            = string
    memory_alert_conditions_display_name = string
    memory_alert_threshold_value         = number
    memory_alert_duration                = string
    memory_alert_alignment_period        = string
    memory_alert_comparison              = string
    memory_alert_filter                  = string
    memory_alert_per_series_aligner      = string
    memory_alert_combiner                = string

    high_cpu_alert_display_name            = string
    high_cpu_alert_conditions_display_name = string
    high_cpu_alert_threshold_value         = number
    high_cpu_alert_duration                = string
    high_cpu_alert_alignment_period        = string
    high_cpu_alert_comparison              = string
    high_cpu_alert_filter                  = string
    high_cpu_alert_per_series_aligner      = string
    high_cpu_alert_combiner                = string

    iops_alert_display_name            = string
    iops_alert_conditions_display_name = string
    iops_alert_threshold_value         = number
    iops_alert_duration                = string
    iops_alert_alignment_period        = string
    iops_alert_comparison              = string
    iops_alert_filter                  = string
    iops_alert_per_series_aligner      = string
    iops_alert_combiner                = string

    api_requests_alert_display_name            = string
    api_requests_alert_conditions_display_name = string
    api_requests_alert_threshold_value         = number
    api_requests_alert_duration                = string
    api_requests_alert_alignment_period        = string
    api_requests_alert_comparison              = string
    api_requests_alert_filter                  = string
    api_requests_alert_per_series_aligner      = string
    api_requests_alert_combiner                = string

    bandwidth_alert_display_name            = string
    bandwidth_alert_conditions_display_name = string
    bandwidth_alert_threshold_value         = number
    bandwidth_alert_duration                = string
    bandwidth_alert_alignment_period        = string
    bandwidth_alert_comparison              = string
    bandwidth_alert_filter                  = string
    bandwidth_alert_per_series_aligner      = string
    bandwidth_alert_combiner                = string

    # monitoring_notification_channels = list(string)
    email_notification_display_name = string
    email_notification_address      = string
  }))
}