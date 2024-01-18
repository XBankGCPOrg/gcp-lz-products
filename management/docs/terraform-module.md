# management

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | 2.4.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.0.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 5.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | 2.4.0 |
| <a name="provider_google"></a> [google](#provider\_google) | >= 5.0.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | >= 5.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_billing_dataset"></a> [billing\_dataset](#module\_billing\_dataset) | github.com/XBankGCPOrg/gcp-lz-modules//bigquery/dataset | v2 |
| <a name="module_billing_details_dataset"></a> [billing\_details\_dataset](#module\_billing\_details\_dataset) | github.com/XBankGCPOrg/gcp-lz-modules//bigquery/dataset | v2 |
| <a name="module_budget"></a> [budget](#module\_budget) | github.com/XBankGCPOrg/gcp-lz-modules//budget/ | v2 |
| <a name="module_folder_policy"></a> [folder\_policy](#module\_folder\_policy) | github.com/XBankGCPOrg/gcp-lz-modules//iam/org_policy | v2 |
| <a name="module_folders"></a> [folders](#module\_folders) | github.com/XBankGCPOrg/gcp-lz-modules//resources/multi_level_folder | v2 |
| <a name="module_guardrail_pubsub_topic_alerts"></a> [guardrail\_pubsub\_topic\_alerts](#module\_guardrail\_pubsub\_topic\_alerts) | github.com/XBankGCPOrg/gcp-lz-modules//pubsub/topic | v2 |
| <a name="module_guardrails_artifact_registry"></a> [guardrails\_artifact\_registry](#module\_guardrails\_artifact\_registry) | github.com/XBankGCPOrg/gcp-lz-modules//devops/artifact_registry | v2 |
| <a name="module_guardrails_cloudfunction"></a> [guardrails\_cloudfunction](#module\_guardrails\_cloudfunction) | github.com/XBankGCPOrg/gcp-lz-modules//compute/cloudfunction | v2 |
| <a name="module_guardrails_kms_key"></a> [guardrails\_kms\_key](#module\_guardrails\_kms\_key) | github.com/XBankGCPOrg/gcp-lz-modules//kms/key | v2 |
| <a name="module_guardrails_log_sink"></a> [guardrails\_log\_sink](#module\_guardrails\_log\_sink) | github.com/XBankGCPOrg/gcp-lz-modules//log_sink | v2 |
| <a name="module_guardrails_pubsub_log_topic"></a> [guardrails\_pubsub\_log\_topic](#module\_guardrails\_pubsub\_log\_topic) | github.com/XBankGCPOrg/gcp-lz-modules//pubsub/topic | v2 |
| <a name="module_guardrails_service_identity"></a> [guardrails\_service\_identity](#module\_guardrails\_service\_identity) | github.com/XBankGCPOrg/gcp-lz-modules//resources/service_identity | v2 |
| <a name="module_guardrails_storage"></a> [guardrails\_storage](#module\_guardrails\_storage) | github.com/XBankGCPOrg/gcp-lz-modules//storage/bucket | v2 |
| <a name="module_log_bigquery"></a> [log\_bigquery](#module\_log\_bigquery) | github.com/XBankGCPOrg/gcp-lz-modules//bigquery/dataset | v2 |
| <a name="module_log_pubsub_topic"></a> [log\_pubsub\_topic](#module\_log\_pubsub\_topic) | github.com/XBankGCPOrg/gcp-lz-modules//pubsub/topic | v2 |
| <a name="module_log_sink_all_to_storage"></a> [log\_sink\_all\_to\_storage](#module\_log\_sink\_all\_to\_storage) | github.com/XBankGCPOrg/gcp-lz-modules//log_sink | v2 |
| <a name="module_log_sink_filtered_to_bigquery"></a> [log\_sink\_filtered\_to\_bigquery](#module\_log\_sink\_filtered\_to\_bigquery) | github.com/XBankGCPOrg/gcp-lz-modules//log_sink | v2 |
| <a name="module_log_sink_filtered_to_pubsub"></a> [log\_sink\_filtered\_to\_pubsub](#module\_log\_sink\_filtered\_to\_pubsub) | github.com/XBankGCPOrg/gcp-lz-modules//log_sink | v2 |
| <a name="module_log_storage"></a> [log\_storage](#module\_log\_storage) | github.com/XBankGCPOrg/gcp-lz-modules//storage/bucket | v2 |
| <a name="module_logging_kms_key"></a> [logging\_kms\_key](#module\_logging\_kms\_key) | github.com/XBankGCPOrg/gcp-lz-modules//kms/key | v2 |
| <a name="module_logging_service_identity"></a> [logging\_service\_identity](#module\_logging\_service\_identity) | github.com/XBankGCPOrg/gcp-lz-modules//resources/service_identity | v2 |
| <a name="module_logging_service_identity_for_bigquerry"></a> [logging\_service\_identity\_for\_bigquerry](#module\_logging\_service\_identity\_for\_bigquerry) | github.com/XBankGCPOrg/gcp-lz-modules//resources/service_identity | v2 |
| <a name="module_monitoring"></a> [monitoring](#module\_monitoring) | github.com/XBankGCPOrg/gcp-lz-modules//monitoring/ | v2 |
| <a name="module_organization"></a> [organization](#module\_organization) | github.com/XBankGCPOrg/gcp-lz-modules//resources/organization | v2 |
| <a name="module_organization_policy"></a> [organization\_policy](#module\_organization\_policy) | github.com/XBankGCPOrg/gcp-lz-modules//iam/org_policy | v2 |
| <a name="module_pricing_dataset"></a> [pricing\_dataset](#module\_pricing\_dataset) | github.com/XBankGCPOrg/gcp-lz-modules//bigquery/dataset | v2 |
| <a name="module_project_policy"></a> [project\_policy](#module\_project\_policy) | github.com/XBankGCPOrg/gcp-lz-modules//iam/org_policy | v2 |
| <a name="module_projects"></a> [projects](#module\_projects) | github.com/XBankGCPOrg/gcp-lz-modules//resources/project | v2 |
| <a name="module_service_account"></a> [service\_account](#module\_service\_account) | github.com/XBankGCPOrg/gcp-lz-modules//iam/service_account | v2 |
| <a name="module_service_accounts"></a> [service\_accounts](#module\_service\_accounts) | github.com/XBankGCPOrg/gcp-lz-modules//iam/service_account | v2 |
| <a name="module_service_identity"></a> [service\_identity](#module\_service\_identity) | github.com/XBankGCPOrg/gcp-lz-modules//resources/service_identity | v2 |

## Resources

| Name | Type |
|------|------|
| [google-beta_google_iam_deny_policy.deny_policy](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_iam_deny_policy) | resource |
| [google_folder_iam_audit_config.folder_config](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/folder_iam_audit_config) | resource |
| [google_folder_iam_member.folder](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/folder_iam_member) | resource |
| [google_organization_iam_audit_config.org_config](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_audit_config) | resource |
| [google_organization_iam_custom_role.organization](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_custom_role) | resource |
| [google_organization_iam_member.organization](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_member) | resource |
| [google_project_iam_audit_config.project_config](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_audit_config) | resource |
| [google_project_iam_custom_role.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_member.bigquery_sink_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_pubsub_topic_iam_member.guardrails_pubsub_sink_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic_iam_member) | resource |
| [google_pubsub_topic_iam_member.pubsub_sink_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic_iam_member) | resource |
| [google_resource_manager_lien.lien](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/resource_manager_lien) | resource |
| [google_service_account_iam_member.service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_storage_bucket_iam_member.storage_sink_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [google_storage_bucket_object.guardrails](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object) | resource |
| [archive_file.guardrails_source](https://registry.terraform.io/providers/hashicorp/archive/2.4.0/docs/data-sources/file) | data source |
| [google_bigquery_default_service_account.account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/bigquery_default_service_account) | data source |
| [google_organization.organization](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/organization) | data source |
| [google_storage_project_service_account.account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/storage_project_service_account) | data source |
| [google_storage_project_service_account.guardrails_gcs_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/storage_project_service_account) | data source |
| [google_storage_project_service_account.logging_gcs_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/storage_project_service_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | The billing account to use for all resources | `string` | n/a | yes |
| <a name="input_budget_config"></a> [budget\_config](#input\_budget\_config) | Configuration for setting GCP budget | <pre>list(object({<br>    billing_account          = string<br>    projects                 = list(string)<br>    create_budget            = bool<br>    display_name             = string<br>    credit_types_treatment   = string<br>    services                 = list(string)<br>    calendar_period          = string<br>    custom_period_start_date = string<br>    custom_period_end_date   = string<br>    alert_spent_percents     = list(number)<br>    alert_spend_basis        = string<br>    # alert_pubsub_topic               = string<br>    # monitoring_notification_channels = list(string)<br>    labels                = map(string)<br>    budget_amount_sandbox = string<br>    budget_amount_default = string<br>    currency_code         = string<br>    project_prefix        = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_deny_policies"></a> [deny\_policies](#input\_deny\_policies) | Deny policies | `any` | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | The domain to bootstrap | `string` | n/a | yes |
| <a name="input_foundation_hierarchy"></a> [foundation\_hierarchy](#input\_foundation\_hierarchy) | Foundation Resource Hierarchy | <pre>object({<br>    folders = list(object({<br>      displayName = string<br>      parent      = string<br>    }))<br>    projects = list(object({<br>      displayName       = string<br>      parent            = string<br>      services          = list(string)<br>      labels            = map(string)<br>      importedProjectId = optional(string, null)<br>      lienReason        = optional(string)<br>      serviceIdentities = optional(list(string), [])<br>      serviceAccounts = optional(list(object({<br>        name        = string<br>        displayName = string<br>        description = string<br>      })), [])<br>    }))<br>    #    subscriptions = list(object({}))<br>    subscriptions = list(object({<br>      name                         = string<br>      labels                       = optional(map(string))<br>      ack_deadline_seconds         = optional(number)<br>      message_retention_duration   = optional(string)<br>      retain_acked_messages        = optional(bool, false)<br>      expiration_policy_ttl        = optional(string)<br>      filter                       = optional(string)<br>      enable_message_ordering      = optional(bool, false)<br>      enable_exactly_once_delivery = optional(bool, false)<br>      dead_letter_policy = optional(object({<br>        topic                 = string<br>        max_delivery_attempts = optional(number)<br>      }))<br>      retry_policy = optional(object({<br>        minimum_backoff = optional(number)<br>        maximum_backoff = optional(number)<br>      }))<br><br>      bigquery = optional(object({<br>        table               = string<br>        use_topic_schema    = optional(bool, false)<br>        write_metadata      = optional(bool, false)<br>        drop_unknown_fields = optional(bool, false)<br>      }))<br>      cloud_storage = optional(object({<br>        bucket          = string<br>        filename_prefix = optional(string)<br>        filename_suffix = optional(string)<br>        max_duration    = optional(string)<br>        max_bytes       = optional(number)<br>        avro_config = optional(object({<br>          write_metadata = optional(bool, false)<br>        }))<br>      }))<br>      push = optional(object({<br>        endpoint   = string<br>        attributes = optional(map(string))<br>        no_wrapper = optional(bool, false)<br>        oidc_token = optional(object({<br>          audience              = optional(string)<br>          service_account_email = string<br>        }))<br>      }))<br><br>      iam = optional(map(list(string)), {})<br>      iam_bindings = optional(map(object({<br>        members = optional(list(string))<br>        role    = optional(string)<br>        condition = optional(object({<br>          expression  = string<br>          title       = string<br>          description = optional(string)<br>        }))<br>      })), {})<br>      iam_bindings_additive = optional(map(object({<br>        member = optional(string)<br>        role   = optional(string)<br>        condition = optional(object({<br>          expression  = string<br>          title       = string<br>          description = optional(string)<br>        }))<br>      })), {})<br>    }))<br><br><br>  })</pre> | n/a | yes |
| <a name="input_iam_policy"></a> [iam\_policy](#input\_iam\_policy) | IAM role binding | <pre>object({<br>    organizations = list(object({<br>      name = string<br>      iamPolicy = optional(object({<br>        bindings = optional(list(object({<br>          roles   = optional(list(string))<br>          members = optional(list(string))<br>        })), [])<br>      }), {})<br>      roles = optional(list(object({<br>        name                = optional(string)<br>        title               = optional(string)<br>        description         = optional(string)<br>        includedPermissions = optional(list(string))<br>      })), [])<br>    }))<br>    folders = list(object({<br>      name = string<br>      iamPolicy = object({<br>        bindings = list(object({<br>          roles   = list(string)<br>          members = list(string)<br>        }))<br>      })<br>    }))<br>    projects = list(object({<br>      name = string<br>      iamPolicy = optional(object({<br>        bindings = optional(list(object({<br>          roles   = optional(list(string))<br>          members = optional(list(string))<br>        })), [])<br>      }), {})<br>      roles = optional(list(object({<br>        name                = optional(string)<br>        title               = optional(string)<br>        description         = optional(string)<br>        includedPermissions = optional(list(string))<br>      })), [])<br>    }))<br>    serviceAccounts = list(object({<br>      name = string<br>      iamPolicy = object({<br>        bindings = list(object({<br>          roles   = list(string)<br>          members = list(string)<br>        }))<br>      })<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels to apply to all foundation projects | `map(string)` | <pre>{<br>  "application_name": "seed-bootstrap",<br>  "env_code": "b",<br>  "environment": "bootstrap"<br>}</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | The location to deploy resource | `string` | n/a | yes |
| <a name="input_monitoring_config"></a> [monitoring\_config](#input\_monitoring\_config) | Configuration for monitoring metrics and alerts | <pre>list(object({<br>    project_id              = string<br>    cpu_metric_display_name = string<br>    cpu_metric_description  = string<br>    cpu_metric_kind         = string<br>    cpu_metric_value_type   = string<br>    cpu_metric_unit         = string<br>    cpu_metric_metric_type  = string<br><br>    memory_display_name = string<br>    memory_description  = string<br>    memory_metric_kind  = string<br>    memory_value_type   = string<br>    memory_unit         = string<br>    memory_type         = string<br><br>    iops_display_name = string<br>    iops_description  = string<br>    iops_metric_kind  = string<br>    iops_value_type   = string<br>    iops_unit         = string<br>    iops_type         = string<br><br>    api_requests_display_name = string<br>    api_requests_description  = string<br>    api_requests_metric_kind  = string<br>    api_requests_value_type   = string<br>    api_requests_unit         = string<br>    api_requests_type         = string<br><br>    bandwidth_display_name       = string<br>    bandwidth_description        = string<br>    bandwidth_metric_metric_kind = string<br>    bandwidth_metric_value_type  = string<br>    bandwidth_metric_unit        = string<br>    bandwidth_metric_type        = string<br><br>    memory_alert_display_name            = string<br>    memory_alert_conditions_display_name = string<br>    memory_alert_threshold_value         = number<br>    memory_alert_duration                = string<br>    memory_alert_alignment_period        = string<br>    memory_alert_comparison              = string<br>    memory_alert_filter                  = string<br>    memory_alert_per_series_aligner      = string<br>    memory_alert_combiner                = string<br><br>    high_cpu_alert_display_name            = string<br>    high_cpu_alert_conditions_display_name = string<br>    high_cpu_alert_threshold_value         = number<br>    high_cpu_alert_duration                = string<br>    high_cpu_alert_alignment_period        = string<br>    high_cpu_alert_comparison              = string<br>    high_cpu_alert_filter                  = string<br>    high_cpu_alert_per_series_aligner      = string<br>    high_cpu_alert_combiner                = string<br><br>    iops_alert_display_name            = string<br>    iops_alert_conditions_display_name = string<br>    iops_alert_threshold_value         = number<br>    iops_alert_duration                = string<br>    iops_alert_alignment_period        = string<br>    iops_alert_comparison              = string<br>    iops_alert_filter                  = string<br>    iops_alert_per_series_aligner      = string<br>    iops_alert_combiner                = string<br><br>    api_requests_alert_display_name            = string<br>    api_requests_alert_conditions_display_name = string<br>    api_requests_alert_threshold_value         = number<br>    api_requests_alert_duration                = string<br>    api_requests_alert_alignment_period        = string<br>    api_requests_alert_comparison              = string<br>    api_requests_alert_filter                  = string<br>    api_requests_alert_per_series_aligner      = string<br>    api_requests_alert_combiner                = string<br><br>    bandwidth_alert_display_name            = string<br>    bandwidth_alert_conditions_display_name = string<br>    bandwidth_alert_threshold_value         = number<br>    bandwidth_alert_duration                = string<br>    bandwidth_alert_alignment_period        = string<br>    bandwidth_alert_comparison              = string<br>    bandwidth_alert_filter                  = string<br>    bandwidth_alert_per_series_aligner      = string<br>    bandwidth_alert_combiner                = string<br><br>    #monitoring_notification_channels = list(string)<br>    email_notification_display_name = string<br>    email_notification_address      = string<br>  }))</pre> | n/a | yes |
| <a name="input_org_policy"></a> [org\_policy](#input\_org\_policy) | Organization policies | `any` | n/a | yes |
| <a name="input_project_billing"></a> [project\_billing](#input\_project\_billing) | Billing project name | `string` | n/a | yes |
| <a name="input_project_guardrails"></a> [project\_guardrails](#input\_project\_guardrails) | Security gaurdrail project name | `string` | n/a | yes |
| <a name="input_project_logging"></a> [project\_logging](#input\_project\_logging) | Logging project name | `string` | n/a | yes |
| <a name="input_test_flag"></a> [test\_flag](#input\_test\_flag) | n/a | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_artifact_registry_name"></a> [artifact\_registry\_name](#output\_artifact\_registry\_name) | n/a |
| <a name="output_folder_ids"></a> [folder\_ids](#output\_folder\_ids) | n/a |
| <a name="output_lien_name"></a> [lien\_name](#output\_lien\_name) | n/a |
| <a name="output_project_ids"></a> [project\_ids](#output\_project\_ids) | n/a |
| <a name="output_pub_sub_name"></a> [pub\_sub\_name](#output\_pub\_sub\_name) | n/a |
| <a name="output_service_accounts"></a> [service\_accounts](#output\_service\_accounts) | output "guardrails\_cloudfunction\_name" { value = module.guardrails\_cloudfunction[keys(local.guardrails)[0]].google\_cloudfunctions\_function } |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
