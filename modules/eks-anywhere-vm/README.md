<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.32.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.32.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_manifest.cluster](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.nutanixdatacenterconfig](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.nutanixmachineconfig_compute](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.nutanixmachineconfig_etcd](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.nutanixmachineconfig_gitaly](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the eks-d cluster being created. | `string` | n/a | yes |
| <a name="input_compute_node_count"></a> [compute\_node\_count](#input\_compute\_node\_count) | The number of compute nodes to create. | `number` | `3` | no |
| <a name="input_compute_node_cpu_count"></a> [compute\_node\_cpu\_count](#input\_compute\_node\_cpu\_count) | Number of CPU that should be allocated for each compute node. Default value is for example only and should be scaled based on workload. | `number` | `4` | no |
| <a name="input_compute_node_memory"></a> [compute\_node\_memory](#input\_compute\_node\_memory) | Amount of memory to set for each compute node. Defaults are for example only and should be scaled based on workload. | `string` | `"4Gi"` | no |
| <a name="input_compute_system_disk_size"></a> [compute\_system\_disk\_size](#input\_compute\_system\_disk\_size) | Amount of storage to configure for each compute node host disk. | `string` | `"40Gi"` | no |
| <a name="input_control_plane_cert_sans"></a> [control\_plane\_cert\_sans](#input\_control\_plane\_cert\_sans) | IP and DNS SANs to add to kube-api certificates. Typically should include a hostname and/or the value you set for control\_plane\_host. | `list(string)` | n/a | yes |
| <a name="input_control_plane_count"></a> [control\_plane\_count](#input\_control\_plane\_count) | The number of compute nodes to create. Defaults to 3 for an HA control plane. | `number` | `3` | no |
| <a name="input_control_plane_host"></a> [control\_plane\_host](#input\_control\_plane\_host) | The DNS name or IP address to use for the server/controlplane. This is independent of the IPs that get assigned to control plane nodes via DHCP and if an IP is used it should be outside of the DHCP range. | `string` | n/a | yes |
| <a name="input_cp_node_cpu_count"></a> [cp\_node\_cpu\_count](#input\_cp\_node\_cpu\_count) | Number of CPU that should be allocated for each control plane node. Default value is for example only and should be scaled based on workload. | `number` | `4` | no |
| <a name="input_cp_node_memory"></a> [cp\_node\_memory](#input\_cp\_node\_memory) | Amount of memory to set for each control plane node. Defaults are for example only and should be scaled based on workload. | `string` | `"4Gi"` | no |
| <a name="input_cp_system_disk_size"></a> [cp\_system\_disk\_size](#input\_cp\_system\_disk\_size) | Amount of storage to configure for each control plane node host disk. | `string` | `"40Gi"` | no |
| <a name="input_etcd_node_count"></a> [etcd\_node\_count](#input\_etcd\_node\_count) | The number of etcd nodes to create. Defaults to 3 for HA etcd. | `number` | `3` | no |
| <a name="input_etcd_node_cpu_count"></a> [etcd\_node\_cpu\_count](#input\_etcd\_node\_cpu\_count) | Number of CPU that should be allocated for each etcd node. Default value is for example only and should be scaled based on workload. | `number` | `4` | no |
| <a name="input_etcd_node_memory"></a> [etcd\_node\_memory](#input\_etcd\_node\_memory) | Amount of memory to set for each etcd node. Defaults are for example only and should be scaled based on workload. | `string` | `"4Gi"` | no |
| <a name="input_etcd_system_disk_size"></a> [etcd\_system\_disk\_size](#input\_etcd\_system\_disk\_size) | Amount of storage to configure for each etcd node host disk. | `string` | `"40Gi"` | no |
| <a name="input_gitaly_dedicated_node_count"></a> [gitaly\_dedicated\_node\_count](#input\_gitaly\_dedicated\_node\_count) | The number of dedicated gitaly nodes to create. | `number` | `1` | no |
| <a name="input_gitaly_node_cpu_count"></a> [gitaly\_node\_cpu\_count](#input\_gitaly\_node\_cpu\_count) | Number of CPU that should be allocated for each dedicated gitaly node. Default value is for example only and should be scaled based on workload. | `number` | `4` | no |
| <a name="input_gitaly_node_memory"></a> [gitaly\_node\_memory](#input\_gitaly\_node\_memory) | Amount of memory to set for each dedicated gitaly node. Defaults are for example only and should be scaled based on workload. | `string` | `"4Gi"` | no |
| <a name="input_gitaly_system_disk_size"></a> [gitaly\_system\_disk\_size](#input\_gitaly\_system\_disk\_size) | Amount of storage to configure for each dedicated gitaly node host disk. | `string` | `"40Gi"` | no |
| <a name="input_kube_version"></a> [kube\_version](#input\_kube\_version) | What version of kubernetes to deploy. The version chosen must be included in the name of the node\_image being used. Example 1.29 | `string` | n/a | yes |
| <a name="input_management_cluster_name"></a> [management\_cluster\_name](#input\_management\_cluster\_name) | Name of the eks-d management cluster that has eka-anywhere configured and is used to manage workload clusters. Default is based on example management cluster from eks-anywhere docs. | `string` | `"mgmt"` | no |
| <a name="input_node_image_name"></a> [node\_image\_name](#input\_node\_image\_name) | The name of the eks node image to use to create eks-d node VMs. Must include the kube\_version in the name. Example eks-rhel-node-image-1.29 | `string` | n/a | yes |
| <a name="input_node_os_family"></a> [node\_os\_family](#input\_node\_os\_family) | OS family used by node image. Valid options are redhat or ubuntu for Nutanix. | `string` | `"redhat"` | no |
| <a name="input_node_ssh_keys"></a> [node\_ssh\_keys](#input\_node\_ssh\_keys) | List of SSH keys to allow eksa user to access the VMs deployed for all cluster nodes. | `list(string)` | n/a | yes |
| <a name="input_nutanix_cluster_name"></a> [nutanix\_cluster\_name](#input\_nutanix\_cluster\_name) | The name of the Nutanix cluster to deploy the eks-d cluster into. | `string` | n/a | yes |
| <a name="input_nutanix_subnet_name"></a> [nutanix\_subnet\_name](#input\_nutanix\_subnet\_name) | Nutanix subnet name to deploy cluster into. | `string` | n/a | yes |
| <a name="input_prism_central_endpoint"></a> [prism\_central\_endpoint](#input\_prism\_central\_endpoint) | IP or hostname of Prism Central. | `string` | n/a | yes |
| <a name="input_prism_central_insecure"></a> [prism\_central\_insecure](#input\_prism\_central\_insecure) | If TLS verification for the prism central endpoint should be disabled. | `bool` | `false` | no |
| <a name="input_prism_central_port"></a> [prism\_central\_port](#input\_prism\_central\_port) | The port used to connect to Prism Central. | `string` | `"9440"` | no |
| <a name="input_registry_mirror_ca_cert"></a> [registry\_mirror\_ca\_cert](#input\_registry\_mirror\_ca\_cert) | CA cert used to sign the cert served by the eks-d registry mirror. If this isn't provided, then registry\_mirror\_insecure must be set to true. | `string` | `""` | no |
| <a name="input_registry_mirror_host"></a> [registry\_mirror\_host](#input\_registry\_mirror\_host) | The hostname/IP of the eks-d registry mirror to use for an airgap cluster installation. | `string` | `""` | no |
| <a name="input_registry_mirror_insecure"></a> [registry\_mirror\_insecure](#input\_registry\_mirror\_insecure) | Set to true if TLS verification should be skipped for the registry mirror. | `bool` | `false` | no |
| <a name="input_registry_mirror_port"></a> [registry\_mirror\_port](#input\_registry\_mirror\_port) | The port used by the registry mirror to serve eks-d images. | `string` | `"5000"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->