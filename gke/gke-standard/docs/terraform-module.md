# gke-standard

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
| <a name="module_gke-standard"></a> [gke-standard](#module\_gke-standard) | github.com/XBankGCPOrg/gcp-lz-modules//gke/gke-standard | 1760227d2489552b4d599ea459fd73987b834c60 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_config"></a> [cluster\_config](#input\_cluster\_config) | GKE Autopilot cluster configuration | <pre>object({<br>    name                       = string<br>    region                     = string<br>    network                    = string<br>    subnetwork                 = string<br>    ip_range_pods              = string<br>    ip_range_services          = string<br>    project_id                 = string<br>    master_ipv4_cidr           = string<br>    master_authorized_networks = string<br>    create_service_account     = bool<br>    network_project_id         = string<br>    #    local.region                  = string <br>    service_account = string<br>    #    cluster_secondary_range_name  = string<br>    #    services_secondary_range_name = string<br>    #    security_group                = string<br>    resource_labels = map(string)<br>    machine_type    = string<br>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
