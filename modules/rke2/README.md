# RKE2 Module

This module depends on a Nutanix cluster already being configured with a subnet as well as an image being available that was built by the uds-package-builder.

An example set of variables passed to the module looks something like this:
```
nutanix_cluster     = "Your-Cluster"
nutanix_subnet      = "Your Subnet"
name                = "example-rke2"
server_count        = 3
agent_count         = 3
server_memory       = 16 * 1024
server_cpu          = 8
agent_memory        = 32 * 1024
agent_cpu           = 16
image_name          = "uds-rke2-rhel-some-build-tag"
ssh_authorized_keys = ["ssh-rsa rest of your key here", "ssh-rsa different key here"]
server_dns_name     = "example-rke2.your-domain.com"
```

This set of variables would configure the module to deploy 6 VMs into the subnet named "Your Subnet" in the Nutanix cluster named "Your-Cluster". 3 of the VMs would be configured as RKE2 control plane nodes with 8 CPU and 16GiB of memory, and the other 3 VMs would be configured as agent nodes with 16 CPU and 32GiB of memory. The VMs would all be given names prefixed with "example-rke2" followed by a unique identifier and a count. For example the control plane VM names might look like "example-rke2-abc-server-0", "example-rke2-abc-server-1", etc. This would also configure each VM to allow signing in with either of the SSH keys added to the ssh_authorized_keys list. The current cloud-config configures all VMs with a default user named `nutanix` that can only log in with one of the SSH keys provided.

The `server_dns_name` variable configures both the hostname used by nodes to join the cluster, as well as the hostname you expect to use to access the kube-api. This hostname is added as a TLS SAN to the cert used by kube-api which is required for kubectl to trust the certificate when hitting the API with a hostname. When setting this variable, it is required that DNS be updated to route the hostname either to a TCP load balancer or directly to the server node IPs once the VMs are created and acquire IPs. This enables nodes to join the cluster eventually as the bootstrap and subsequent server nodes startup and join. If this variable is not set then nodes will join the cluster using the IP address of the bootstrap control plane node (the first one that starts up) and the API certs will only be valid for the control plane private IPs and the loopback address. It is not recommended to deploy a cluster without setting this to a domain name that you can configure to route to the control plane nodes.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_nutanix"></a> [nutanix](#requirement\_nutanix) | >= 1.9.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_nutanix"></a> [nutanix](#provider\_nutanix) | 1.9.3 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [nutanix_virtual_machine.rke2_agents](https://registry.terraform.io/providers/nutanix/nutanix/latest/docs/resources/virtual_machine) | resource |
| [nutanix_virtual_machine.rke2_bootstrap](https://registry.terraform.io/providers/nutanix/nutanix/latest/docs/resources/virtual_machine) | resource |
| [nutanix_virtual_machine.rke2_servers](https://registry.terraform.io/providers/nutanix/nutanix/latest/docs/resources/virtual_machine) | resource |
| [random_password.token](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
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
| <a name="input_agent_secondary_disk_size"></a> [agent\_secondary\_disk\_size](#input\_agent\_secondary\_disk\_size) | The size of the secondary disk for agent VMs in MiB. Secondary disk is used for PVC/object storage with rook/ceph. | `number` | `307200` | no |
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | The name of the image to use for virtual machines. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name to use for VMs and other resources. | `string` | `"rke2"` | no |
| <a name="input_nutanix_cluster"></a> [nutanix\_cluster](#input\_nutanix\_cluster) | The name of the Nutanix cluster to deploy to. | `string` | n/a | yes |
| <a name="input_nutanix_subnet"></a> [nutanix\_subnet](#input\_nutanix\_subnet) | The name of the subnet to deploy VMs to. | `string` | n/a | yes |
| <a name="input_server_count"></a> [server\_count](#input\_server\_count) | The number of server VMs to deploy. | `number` | `3` | no |
| <a name="input_server_cpu"></a> [server\_cpu](#input\_server\_cpu) | The number of CPUs for each server VM. | `number` | n/a | yes |
| <a name="input_server_cpu_cores"></a> [server\_cpu\_cores](#input\_server\_cpu\_cores) | The number of CPU cores, per CPU, for each server VM. | `number` | `1` | no |
| <a name="input_server_dns_name"></a> [server\_dns\_name](#input\_server\_dns\_name) | The DNS name to use for the server/controlplane. Should route round robin to all IPs under server\_ip\_list. | `string` | `""` | no |
| <a name="input_server_ip_list"></a> [server\_ip\_list](#input\_server\_ip\_list) | The list of IPs for server nodes. List must be >= server\_count. | `list(string)` | `[]` | no |
| <a name="input_server_memory"></a> [server\_memory](#input\_server\_memory) | The amount of memory for each server VM in MiB. | `number` | n/a | yes |
| <a name="input_server_primary_disk_size"></a> [server\_primary\_disk\_size](#input\_server\_primary\_disk\_size) | The size of the primary disk for server VMs in MiB. Primary disk is the boot disk and contains ephemeral storage. | `number` | `153600` | no |
| <a name="input_server_secondary_disk_size"></a> [server\_secondary\_disk\_size](#input\_server\_secondary\_disk\_size) | The size of the secondary disk for server VMs in MiB. Secondary disk is used for PVC/object storage with rook/ceph. | `number` | `307200` | no |
| <a name="input_ssh_authorized_keys"></a> [ssh\_authorized\_keys](#input\_ssh\_authorized\_keys) | A list of authorized public SSH keys to allow for login to the nutanix user on all nodes | `list(string)` | n/a | yes |
| <a name="input_unique_suffix"></a> [unique\_suffix](#input\_unique\_suffix) | Whether to add a unique suffix to the name. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bootstrap_ip"></a> [bootstrap\_ip](#output\_bootstrap\_ip) | IP address for the bootstrap virtual machines. |
<!-- END_TF_DOCS -->