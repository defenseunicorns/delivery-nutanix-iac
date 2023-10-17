<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_nutanix"></a> [nutanix](#requirement\_nutanix) | >= 1.9.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_nutanix"></a> [nutanix](#provider\_nutanix) | >= 1.9.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [nutanix_subnet.subnet](https://registry.terraform.io/providers/nutanix/nutanix/latest/docs/resources/subnet) | resource |
| [nutanix_cluster.cluster](https://registry.terraform.io/providers/nutanix/nutanix/latest/docs/data-sources/cluster) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dhcp_domain_search_list"></a> [dhcp\_domain\_search\_list](#input\_dhcp\_domain\_search\_list) | List of DHCP domain search list | `list(string)` | `[]` | no |
| <a name="input_dhcp_name_servers"></a> [dhcp\_name\_servers](#input\_dhcp\_name\_servers) | List of DHCP domain name servers | `list(string)` | `[]` | no |
| <a name="input_gateway_ip"></a> [gateway\_ip](#input\_gateway\_ip) | The default gateway IP for the subnet, ex: 192.168.101.1 | `string` | `""` | no |
| <a name="input_ip_pool_range"></a> [ip\_pool\_range](#input\_ip\_pool\_range) | The IP pool for the subnet, space delimited starting and ending IP, ex: 192.168.101.100 192.168.101.200 | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to use for subnet. | `string` | n/a | yes |
| <a name="input_nutanix_cluster"></a> [nutanix\_cluster](#input\_nutanix\_cluster) | The name of the Nutanix cluster to deploy to. | `string` | n/a | yes |
| <a name="input_prefix_length"></a> [prefix\_length](#input\_prefix\_length) | The prefix length of the subnet, ex: 24 | `number` | `null` | no |
| <a name="input_subnet_ip"></a> [subnet\_ip](#input\_subnet\_ip) | The subnet IP for the subnet, ex: 192.168.101.0 | `string` | `""` | no |
| <a name="input_vlan_id"></a> [vlan\_id](#input\_vlan\_id) | VLAN ID for the subnet, ex: 101 | `number` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnet_name"></a> [subnet\_name](#output\_subnet\_name) | Name of the created subnet. |
| <a name="output_subnet_uuid"></a> [subnet\_uuid](#output\_subnet\_uuid) | UUID of the created subnet. |
<!-- END_TF_DOCS -->