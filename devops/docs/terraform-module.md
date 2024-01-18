# devops

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.0.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 5.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 5.0.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | >= 5.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_control_kms_key"></a> [control\_kms\_key](#module\_control\_kms\_key) | github.com/XBankGCPOrg/gcp-lz-modules//kms/key | 35e1ac51b81725fb3378b83f10f3cae9b2956e78 |
| <a name="module_folders"></a> [folders](#module\_folders) | github.com/XBankGCPOrg/gcp-lz-modules//resources/folder | 35e1ac51b81725fb3378b83f10f3cae9b2956e78 |
| <a name="module_individual_state_files"></a> [individual\_state\_files](#module\_individual\_state\_files) | github.com/XBankGCPOrg/gcp-lz-modules//storage/bucket | 35e1ac51b81725fb3378b83f10f3cae9b2956e78 |
| <a name="module_organization"></a> [organization](#module\_organization) | github.com/XBankGCPOrg/gcp-lz-modules//resources/organization | 35e1ac51b81725fb3378b83f10f3cae9b2956e78 |
| <a name="module_projects"></a> [projects](#module\_projects) | github.com/XBankGCPOrg/gcp-lz-modules//resources/project | 35e1ac51b81725fb3378b83f10f3cae9b2956e78 |
| <a name="module_service_account"></a> [service\_account](#module\_service\_account) | github.com/XBankGCPOrg/gcp-lz-modules//iam/service_account | 35e1ac51b81725fb3378b83f10f3cae9b2956e78 |

## Resources

| Name | Type |
|------|------|
| [google-beta_google_iam_workload_identity_pool.github](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_iam_workload_identity_pool) | resource |
| [google-beta_google_iam_workload_identity_pool_provider.github](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_iam_workload_identity_pool_provider) | resource |
| [google_billing_account_iam_member.binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/billing_account_iam_member) | resource |
| [google_billing_account_iam_member.binding_admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/billing_account_iam_member) | resource |
| [google_organization_iam_member.organization](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_member) | resource |
| [google_project_organization_policy.iam_disableCrossProjectServiceAccountUsage](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_organization_policy) | resource |
| [google_resource_manager_lien.lien](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/resource_manager_lien) | resource |
| [google_service_account_iam_member.sa_service_account_token_creator](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_service_account_iam_member.sa_service_account_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_service_account_iam_member.wif-sa-bind](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_storage_bucket_iam_member.sa_service_account_state_individual_storage_admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [google_storage_project_service_account.control_gcs_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/storage_project_service_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | The billing account to use for all resources | `string` | n/a | yes |
| <a name="input_bootstrap_folder_name"></a> [bootstrap\_folder\_name](#input\_bootstrap\_folder\_name) | Bootstrap Folder | `string` | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | The domain to bootstrap | `string` | n/a | yes |
| <a name="input_enable_apis"></a> [enable\_apis](#input\_enable\_apis) | Terraform GCS bucket name | `list(string)` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels to apply to all foundation projects | `map(string)` | <pre>{<br>  "application_name": "seed-bootstrap",<br>  "env_code": "b",<br>  "environment": "bootstrap"<br>}</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | The location to deploy resource | `string` | n/a | yes |
| <a name="input_sa_iam_org_binding"></a> [sa\_iam\_org\_binding](#input\_sa\_iam\_org\_binding) | IAM policy binding for WIF service account | `any` | n/a | yes |
| <a name="input_seed_project_name"></a> [seed\_project\_name](#input\_seed\_project\_name) | Seed project Name | `string` | n/a | yes |
| <a name="input_service_accounts"></a> [service\_accounts](#input\_service\_accounts) | Repository information. eg: your\_org/your\_repository | `map(list(map(string)))` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_workload_identity_provider"></a> [workload\_identity\_provider](#output\_workload\_identity\_provider) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
