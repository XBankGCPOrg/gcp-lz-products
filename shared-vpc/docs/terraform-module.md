# shared-vpc

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.7.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_shared-VPC"></a> [shared-VPC](#module\_shared-VPC) | github.com/XBankGCPOrg/gcp-lz-modules//shared_vpc | v2 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_shared_vpc"></a> [shared\_vpc](#input\_shared\_vpc) | n/a | <pre>list(object({<br>    host_project    = string<br>    service_project = string<br>    service_account = string<br>    subnet          = list(string)<br>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
