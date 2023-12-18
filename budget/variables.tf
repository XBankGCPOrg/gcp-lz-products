variable "budget_config" {
  description = "Configuration for setting GCP budget"
  type = object({
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
  })
  /*default = {
    billing_account                 = "01EBA6-74BB59-078C79"
    projects                        = ["prj-s-my-test-project-85526"]
    create_budget                   = true
    display_name                    = null
    credit_types_treatment          = "INCLUDE_ALL_CREDITS"
    services                        = null
    calendar_period                 = null
    custom_period_start_date        = null
    custom_period_end_date          = null
    alert_spent_percents            = [0.5, 0.7, 1.0]
    alert_spend_basis               = "CURRENT_SPEND"
    alert_pubsub_topic              = null
    monitoring_notification_channels = []
    labels                          = {}
    budget_amount_sandbox           = "500"
    budget_amount_default           = "5000"
    currency_code                   = "USD"
    project_prefix                  = "prj-s-"
  }*/
}
