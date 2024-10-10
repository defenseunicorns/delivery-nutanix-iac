<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_nutanix"></a> [nutanix](#requirement\_nutanix) | >= 1.9.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_nutanix"></a> [nutanix](#provider\_nutanix) | >= 1.9.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [nutanix_virtual_machine.eks_anywhere_vm](https://registry.terraform.io/providers/nutanix/nutanix/latest/docs/resources/virtual_machine) | resource |
| [random_string.uid](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [nutanix_cluster.cluster](https://registry.terraform.io/providers/nutanix/nutanix/latest/docs/data-sources/cluster) | data source |
| [nutanix_image.image](https://registry.terraform.io/providers/nutanix/nutanix/latest/docs/data-sources/image) | data source |
| [nutanix_subnet.subnet](https://registry.terraform.io/providers/nutanix/nutanix/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | The name of the eks anywhwere image to use to create an eks-anywhere VM. This VM is used to bootstrap an eks-anywhere management cluster. | `string` | n/a | yes |
| <a name="input_ntp_server"></a> [ntp\_server](#input\_ntp\_server) | IP or hostname of NTP server to use for host | `string` | `""` | no |
| <a name="input_nutanix_cluster"></a> [nutanix\_cluster](#input\_nutanix\_cluster) | The name of the Nutanix cluster to deploy the eks-d cluster into. | `string` | n/a | yes |
| <a name="input_nutanix_password"></a> [nutanix\_password](#input\_nutanix\_password) | Prism Central password used by eks anywhere to provision VMs | `string` | `""` | no |
| <a name="input_nutanix_subnet"></a> [nutanix\_subnet](#input\_nutanix\_subnet) | Nutanix subnet name to deploy cluster into. | `string` | n/a | yes |
| <a name="input_nutanix_username"></a> [nutanix\_username](#input\_nutanix\_username) | Prism Central username used by eks anywhere to provision VMs | `string` | `""` | no |
| <a name="input_registry_mirror_host"></a> [registry\_mirror\_host](#input\_registry\_mirror\_host) | The hostname/IP of the eks-d registry mirror to use for an airgap cluster installation. | `string` | `""` | no |
| <a name="input_registry_mirror_port"></a> [registry\_mirror\_port](#input\_registry\_mirror\_port) | The port used by the registry mirror to serve eks-d images. | `string` | `""` | no |
| <a name="input_ssh_authorized_keys"></a> [ssh\_authorized\_keys](#input\_ssh\_authorized\_keys) | A list of authorized public SSH keys to allow for login to the nutanix user on all nodes | `list(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->