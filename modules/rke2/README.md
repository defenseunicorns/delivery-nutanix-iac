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
| [nutanix_virtual_machine.rke2_agents](https://registry.terraform.io/providers/nutanix/nutanix/latest/docs/resources/virtual_machine) | resource |
| [nutanix_virtual_machine.rke2_bootstrap](https://registry.terraform.io/providers/nutanix/nutanix/latest/docs/resources/virtual_machine) | resource |
| [nutanix_virtual_machine.rke2_servers](https://registry.terraform.io/providers/nutanix/nutanix/latest/docs/resources/virtual_machine) | resource |
| [random_string.uid](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [nutanix_cluster.cluster](https://registry.terraform.io/providers/nutanix/nutanix/latest/docs/data-sources/cluster) | data source |
| [nutanix_image.image](https://registry.terraform.io/providers/nutanix/nutanix/latest/docs/data-sources/image) | data source |
| [nutanix_subnet.subnet](https://registry.terraform.io/providers/nutanix/nutanix/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent_count"></a> [agent\_count](#input\_agent\_count) | The number of agent VMs to deploy. | `number` | `6` | no |
| <a name="input_agent_cpu"></a> [agent\_cpu](#input\_agent\_cpu) | The number of CPUs for each agent VM. | `number` | n/a | yes |
| <a name="input_agent_cpu_cores"></a> [agent\_cpu\_cores](#input\_agent\_cpu\_cores) | The number of CPU cores, per CPU, for each agent VM. | `number` | `1` | no |
| <a name="input_agent_memory"></a> [agent\_memory](#input\_agent\_memory) | The amount of memory for each agent VM in MiB. | `number` | n/a | yes |
| <a name="input_agent_primary_disk_size"></a> [agent\_primary\_disk\_size](#input\_agent\_primary\_disk\_size) | The size of the primary disk for agent VMs in MiB. Primary disk is the boot disk and contains ephemeral storage. | `number` | `153600` | no |
| <a name="input_boot_type"></a> [boot\_type](#input\_boot\_type) | Boot type for cluster VMs. Valid options are UEFI, LEGACY, or SECURE\_BOOT. UEFI is preferred. | `string` | `"UEFI"` | no |
| <a name="input_bootstrap_cluster"></a> [bootstrap\_cluster](#input\_bootstrap\_cluster) | Should module bootstrap a new cluster, or should nodes join an existing cluster? If this is false, then server\_dns\_name must be set for nodes to join a cluster. | `bool` | n/a | yes |
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | The name of the image to use for virtual machines. | `string` | n/a | yes |
| <a name="input_join_token"></a> [join\_token](#input\_join\_token) | Secret used for a node to join the cluster. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name to use for VMs and other resources. | `string` | `"rke2"` | no |
| <a name="input_node_user"></a> [node\_user](#input\_node\_user) | The username to use for the default user on cluster node hosts. | `string` | `"nutanix"` | no |
| <a name="input_nutanix_cluster"></a> [nutanix\_cluster](#input\_nutanix\_cluster) | The name of the Nutanix cluster to deploy to. | `string` | n/a | yes |
| <a name="input_nutanix_subnet"></a> [nutanix\_subnet](#input\_nutanix\_subnet) | The name of the subnet to deploy VMs to. | `string` | n/a | yes |
| <a name="input_server_count"></a> [server\_count](#input\_server\_count) | The number of server VMs to deploy. | `number` | `3` | no |
| <a name="input_server_cpu"></a> [server\_cpu](#input\_server\_cpu) | The number of CPUs for each server VM. | `number` | n/a | yes |
| <a name="input_server_cpu_cores"></a> [server\_cpu\_cores](#input\_server\_cpu\_cores) | The number of CPU cores, per CPU, for each server VM. | `number` | `1` | no |
| <a name="input_server_dns_name"></a> [server\_dns\_name](#input\_server\_dns\_name) | The DNS name to use for the server/controlplane. Should route round robin to all IPs under server\_ip\_list. Required if bootstrap\_cluster is set to false. | `string` | `""` | no |
| <a name="input_server_ip_list"></a> [server\_ip\_list](#input\_server\_ip\_list) | The list of IPs for server nodes. List must be >= server\_count. | `list(string)` | `[]` | no |
| <a name="input_server_memory"></a> [server\_memory](#input\_server\_memory) | The amount of memory for each server VM in MiB. | `number` | n/a | yes |
| <a name="input_server_primary_disk_size"></a> [server\_primary\_disk\_size](#input\_server\_primary\_disk\_size) | The size of the primary disk for server VMs in MiB. Primary disk is the boot disk and contains ephemeral storage. | `number` | `153600` | no |
| <a name="input_ssh_authorized_keys"></a> [ssh\_authorized\_keys](#input\_ssh\_authorized\_keys) | A list of authorized public SSH keys to allow for login to the nutanix user on all nodes | `list(string)` | n/a | yes |
| <a name="input_taint_servers"></a> [taint\_servers](#input\_taint\_servers) | Should taints be applied to server nodes to prevent workloads from scheduling on them? | `bool` | `true` | no |
| <a name="input_unique_suffix"></a> [unique\_suffix](#input\_unique\_suffix) | Whether to add a unique suffix to the name. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bootstrap_ip"></a> [bootstrap\_ip](#output\_bootstrap\_ip) | IP address for the bootstrap virtual machines. |
<!-- END_TF_DOCS -->