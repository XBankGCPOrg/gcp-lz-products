# gke-vm

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
| <a name="module_vm"></a> [vm](#module\_vm) | github.com/XBankGCPOrg/gcp-lz-modules//vm | 32980bd2b869f6688c37501525bedb28d1a7e0ef |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vm_config"></a> [vm\_config](#input\_vm\_config) | Bastion host for GKE | <pre>object({<br>    name       = string<br>    location   = string<br>    network    = string<br>    subnetwork = string<br>    #    create_service_account        = bool<br>    email   = string<br>    project = string<br>    zone    = string<br>    tag     = string<br>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
