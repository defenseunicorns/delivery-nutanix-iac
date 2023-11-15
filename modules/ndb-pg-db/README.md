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
| [nutanix_virtual_machine.postgres_profile_vm](https://registry.terraform.io/providers/nutanix/nutanix/latest/docs/resources/virtual_machine) | resource |
| [random_string.uid](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [nutanix_cluster.cluster](https://registry.terraform.io/providers/nutanix/nutanix/latest/docs/data-sources/cluster) | data source |
| [nutanix_image.image](https://registry.terraform.io/providers/nutanix/nutanix/latest/docs/data-sources/image) | data source |
| [nutanix_subnet.subnet](https://registry.terraform.io/providers/nutanix/nutanix/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cpu"></a> [cpu](#input\_cpu) | The number of CPUs for each server VM. | `number` | `1` | no |
| <a name="input_cpu_cores"></a> [cpu\_cores](#input\_cpu\_cores) | The number of CPU cores, per CPU, for each server VM. | `number` | `4` | no |
| <a name="input_data_disk_size"></a> [data\_disk\_size](#input\_data\_disk\_size) | The size of the secondary disk for server VMs in MiB. Secondary disk is used for postgres data. | `number` | `51200` | no |
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | The name of the image to use for virtual machines. | `string` | n/a | yes |
| <a name="input_memory"></a> [memory](#input\_memory) | The amount of memory for each server VM in MiB. | `number` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name to use for VMs and other resources. | `string` | `"postgres-profile"` | no |
| <a name="input_nutanix_cluster"></a> [nutanix\_cluster](#input\_nutanix\_cluster) | The name of the Nutanix cluster to deploy to. | `string` | n/a | yes |
| <a name="input_nutanix_subnet"></a> [nutanix\_subnet](#input\_nutanix\_subnet) | The name of the subnet to deploy VMs to. | `string` | n/a | yes |
| <a name="input_os_disk_size"></a> [os\_disk\_size](#input\_os\_disk\_size) | The size of the primary disk for server VMs in MiB. Primary disk is the boot disk and contains ephemeral storage. | `number` | `20480` | no |
| <a name="input_pg_password"></a> [pg\_password](#input\_pg\_password) | The password to set for the postgres DB postgres user. This can be anything, but the value needs to be provided to NDB on DB import. | `string` | n/a | yes |
| <a name="input_postgres_version"></a> [postgres\_version](#input\_postgres\_version) | Major version of postgres. | `string` | `"14"` | no |
| <a name="input_ssh_authorized_keys"></a> [ssh\_authorized\_keys](#input\_ssh\_authorized\_keys) | A list of authorized public SSH keys to allow for login to the nutanix user on all nodes | `list(string)` | n/a | yes |
| <a name="input_unique_suffix"></a> [unique\_suffix](#input\_unique\_suffix) | Whether to add a unique suffix to the name. | `bool` | `true` | no |
| <a name="input_user_password"></a> [user\_password](#input\_user\_password) | The password to set for the era user. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bootstrap_ip"></a> [bootstrap\_ip](#output\_bootstrap\_ip) | IP address for the bootstrap virtual machines. |
<!-- END_TF_DOCS -->