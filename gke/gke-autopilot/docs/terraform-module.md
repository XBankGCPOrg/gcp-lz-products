# gke-autopilot

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.7.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 5.7.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gke-autopilot"></a> [gke-autopilot](#module\_gke-autopilot) | github.com/XBankGCPOrg/gcp-lz-modules//gke/gke-autopilot | v2 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_config"></a> [cluster\_config](#input\_cluster\_config) | GKE Autopilot cluster configuration | <pre>object({<br>    name                          = string<br>    location                      = string<br>    network                       = string<br>    subnetwork                    = string<br>    cluster_ipv4_cidr             = string<br>    services_ipv4_cidr            = string<br>    project                       = string<br>    master_ipv4_cidr              = string<br>    master_authorized_networks    = string<br>    create_service_account        = bool<br>    service_account               = string<br>    cluster_secondary_range_name  = string<br>    services_secondary_range_name = string<br>    security_group                = string<br>    resource_labels               = map(string)<br>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
