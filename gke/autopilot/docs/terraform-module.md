# autopilot

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudnat"></a> [cloudnat](#module\_cloudnat) | ../../../gcp-lz-modules/cloudnat | n/a |
| <a name="module_gke"></a> [gke](#module\_gke) | ../../../gcp-lz-modules/gke/autopilot | n/a |
| <a name="module_subnetworks"></a> [subnetworks](#module\_subnetworks) | ../../../gcp-lz-modules/subnetworks | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../../../gcp-lz-modules/vpc | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudnat-name"></a> [cloudnat-name](#input\_cloudnat-name) | n/a | `any` | n/a | yes |
| <a name="input_cluster_ipv4_cidr"></a> [cluster\_ipv4\_cidr](#input\_cluster\_ipv4\_cidr) | n/a | `any` | n/a | yes |
| <a name="input_config_source_subnets"></a> [config\_source\_subnets](#input\_config\_source\_subnets) | n/a | `any` | n/a | yes |
| <a name="input_delete_default_routes_on_create"></a> [delete\_default\_routes\_on\_create](#input\_delete\_default\_routes\_on\_create) | n/a | `any` | n/a | yes |
| <a name="input_enable_private_endpoint"></a> [enable\_private\_endpoint](#input\_enable\_private\_endpoint) | n/a | `any` | n/a | yes |
| <a name="input_gke-location"></a> [gke-location](#input\_gke-location) | n/a | `any` | n/a | yes |
| <a name="input_gke-name"></a> [gke-name](#input\_gke-name) | n/a | `any` | n/a | yes |
| <a name="input_ip_cidr_range"></a> [ip\_cidr\_range](#input\_ip\_cidr\_range) | n/a | `any` | n/a | yes |
| <a name="input_master_ipv4_cidr"></a> [master\_ipv4\_cidr](#input\_master\_ipv4\_cidr) | n/a | `any` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | n/a | `any` | n/a | yes |
| <a name="input_purpose"></a> [purpose](#input\_purpose) | n/a | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `any` | n/a | yes |
| <a name="input_router_create"></a> [router\_create](#input\_router\_create) | n/a | `any` | n/a | yes |
| <a name="input_routing_mode"></a> [routing\_mode](#input\_routing\_mode) | n/a | `any` | n/a | yes |
| <a name="input_services_ipv4_cidr"></a> [services\_ipv4\_cidr](#input\_services\_ipv4\_cidr) | n/a | `any` | n/a | yes |
| <a name="input_subnet-description"></a> [subnet-description](#input\_subnet-description) | n/a | `any` | n/a | yes |
| <a name="input_subnet-name"></a> [subnet-name](#input\_subnet-name) | n/a | `any` | n/a | yes |
| <a name="input_vpc-description"></a> [vpc-description](#input\_vpc-description) | n/a | `any` | n/a | yes |
| <a name="input_vpc-name"></a> [vpc-name](#input\_vpc-name) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
