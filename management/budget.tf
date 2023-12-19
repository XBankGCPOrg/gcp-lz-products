
module "budget" {
  source = "github.com/XBankGCPOrg/gcp-lz-modules//budget/?ref=ba138b9f9ebd8a9048ae39e54ddf0b82c2cdb707"

  for_each                         = { for entry in var.budget_config : entry.display_name => entry }
  billing_account                  = each.value.billing_account
  projects                         = each.value.projects
  create_budget                    = each.value.create_budget
  display_name                     = each.value.display_name
  credit_types_treatment           = each.value.credit_types_treatment
  services                         = each.value.services
  calendar_period                  = each.value.calendar_period
  custom_period_start_date         = each.value.custom_period_start_date
  custom_period_end_date           = each.value.custom_period_end_date
  alert_spent_percents             = each.value.alert_spent_percents
  alert_spend_basis                = each.value.alert_spend_basis
  alert_pubsub_topic               = each.value.alert_pubsub_topic
  monitoring_notification_channels = each.value.monitoring_notification_channels
  labels                           = each.value.labels
  budget_amount_sandbox            = each.value.budget_amount_sandbox
  budget_amount_default            = each.value.budget_amount_default
  currency_code                    = each.value.currency_code
  project_prefix                   = each.value.project_prefix

}