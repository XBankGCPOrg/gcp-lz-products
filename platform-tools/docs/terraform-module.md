# platform-tools

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
| <a name="module_artifact_registry"></a> [artifact\_registry](#module\_artifact\_registry) | github.com/XBankGCPOrg/gcp-lz-modules//devops/artifact_registry | v2 |
| <a name="module_centralized_kms"></a> [centralized\_kms](#module\_centralized\_kms) | github.com/XBankGCPOrg/gcp-lz-modules//kms/key | v2 |

## Resources

| Name | Type |
|------|------|
| [google-beta_google_cloud_asset_resources_search_all.projects](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/data-sources/google_cloud_asset_resources_search_all) | data source |
| [google_organization.organization](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_artifact_registry"></a> [artifact\_registry](#input\_artifact\_registry) | Artifact Registry | <pre>list(object({<br>    name        = string<br>    description = string<br>    project     = string<br>    kms = object({<br>      kmsLocation = string<br>      kmsProject  = string<br>    })<br>    location = string<br>  }))</pre> | n/a | yes |
| <a name="input_centralized_kms"></a> [centralized\_kms](#input\_centralized\_kms) | Centralized KMS | <pre>list(object({<br>    name                     = string<br>    project                  = string<br>    location                 = string<br>    rotationPeriod           = string<br>    destroyScheduledDuration = string<br>    services                 = optional(list(string), [])<br>    encrypters               = optional(list(string), [])<br>    decrypters               = optional(list(string), [])<br>    preventDestroy           = optional(bool, false)<br>  }))</pre> | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | Organization name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_registry_name"></a> [registry\_name](#output\_registry\_name) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
