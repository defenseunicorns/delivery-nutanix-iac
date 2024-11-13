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
| [nutanix_ndb_database.postgres-db](https://registry.terraform.io/providers/nutanix/nutanix/latest/docs/resources/ndb_database) | resource |
| [random_string.uid](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [nutanix_ndb_cluster.cluster](https://registry.terraform.io/providers/nutanix/nutanix/latest/docs/data-sources/ndb_cluster) | data source |
| [nutanix_ndb_profile.compute_profile](https://registry.terraform.io/providers/nutanix/nutanix/latest/docs/data-sources/ndb_profile) | data source |
| [nutanix_ndb_profile.db_param_profile](https://registry.terraform.io/providers/nutanix/nutanix/latest/docs/data-sources/ndb_profile) | data source |
| [nutanix_ndb_profile.network_profile](https://registry.terraform.io/providers/nutanix/nutanix/latest/docs/data-sources/ndb_profile) | data source |
| [nutanix_ndb_profile.software_profile](https://registry.terraform.io/providers/nutanix/nutanix/latest/docs/data-sources/ndb_profile) | data source |
| [nutanix_ndb_sla.sla](https://registry.terraform.io/providers/nutanix/nutanix/latest/docs/data-sources/ndb_sla) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compute_profile_name"></a> [compute\_profile\_name](#input\_compute\_profile\_name) | The name of the compute profile in NDB to use for the DB. Ex: large-compute | `string` | n/a | yes |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | Name to use for postgres DB created during provisioning. | `string` | `"postgres"` | no |
| <a name="input_database_size"></a> [database\_size](#input\_database\_size) | The size in GiB to give for postgres data. | `string` | n/a | yes |
| <a name="input_db_param_profile_name"></a> [db\_param\_profile\_name](#input\_db\_param\_profile\_name) | The name of the database parameter profile in NDB to use for the DB. Ex: DEFAULT\_POSTGRES\_PARAMS | `string` | n/a | yes |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | The password to set for the postgres DB postgres user. | `string` | n/a | yes |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Name used as a prefix for the postgres instance, VM, and time machine names. | `string` | n/a | yes |
| <a name="input_network_profile_name"></a> [network\_profile\_name](#input\_network\_profile\_name) | The name of the network profile in NDB to use for the DB. Ex: DEFAULT\_OOB\_POSTGRESQL\_NETWORK | `string` | n/a | yes |
| <a name="input_nutanix_cluster_name"></a> [nutanix\_cluster\_name](#input\_nutanix\_cluster\_name) | The name of the Nutanix cluster to deploy to. | `string` | n/a | yes |
| <a name="input_sla_name"></a> [sla\_name](#input\_sla\_name) | The name of the time machine SLA in NDB to use for the DB. Ex: DEFAULT\_OOB\_BRASS\_SLA | `string` | n/a | yes |
| <a name="input_software_profile_name"></a> [software\_profile\_name](#input\_software\_profile\_name) | The name of the software profile in NDB to use for the DB. Uses the latest published version of the profile. Ex: 'postgres-14.9' | `string` | n/a | yes |
| <a name="input_ssh_authorized_key"></a> [ssh\_authorized\_key](#input\_ssh\_authorized\_key) | An SSH public key to allow for login to the era user on postgres databases | `string` | n/a | yes |
| <a name="input_unique_suffix"></a> [unique\_suffix](#input\_unique\_suffix) | Whether to add a unique suffix to the instance\_name for the VM, postgres instance, and time machine names. Not added to the database\_name. | `bool` | `true` | no |
| <a name="input_vm_password"></a> [vm\_password](#input\_vm\_password) | The password to set for the VM era user. | `string` | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->