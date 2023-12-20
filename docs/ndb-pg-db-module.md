# NDB PG DB module

This module is used to provision postgres databases using the NDB service. A prerequisite is having the NDB service installed and configured in Nutanix and having any profiles you reference must already be created. An example set of variables passed to the module looks something like this:

```
nutanix_cluster_name   = "Your-Nutanix-Cluster"
ssh_authorized_key     = "your ssh public key"
db_password            = "some-database-password"
vm_password            = "some-vm-user-password"
software_profile_name  = "postgres_14.9"
compute_profile_name   = "large-compute"
network_profile_name   = "DEFAULT_OOB_POSTGRESQL_NETWORK"
db_param_profile_name  = "DEFAULT_POSTGRES_PARAMS"
sla_name               = "DEFAULT_OOB_BRASS_SLA"
database_name          = "yourservicedb"
instance_name          = "vm-name"
database_size          = "200" # initial database size in GiB
```

There are some limitations to managing DB VMs using the NDB service (and by extension, this module). Once a DB VM is created by the NDB service it is not possible to update the VM settings using the NDB service. For example, the compute profile chosen determines the CPU and memory allocation at deploy time, but once the VM is created if these resources need updated it would need to be done via Prism. Once a database is created the only things that can be updated through the NDB service are database size (so if a database needs more storage it can be expanded via NDB), time machine settings, and what databases exist in a postgres instance (you can add and delete databases from the NDB console). This unfortunately means this module is great for provisioning postgres databases, but not very good for managing them after they exist.

When deleting databases provisioned with this module using terraform (either by removing a module definition in a deployment or using terraform destroy) NDB only deletes the NDB Time Machine and removes the database from the database service. It does not delete the VM or the underlying storage volumes. After deleting a database with terraform, to finish cleaning up resources use the "Database Server VMs" view in the NDB console. This page will let you select the VMs that are still registered but aren't being used by NDB anymore and remove them. To do this select a VM that is no longer in use, choose the remove action, and then make sure the "Delete the VM and associated storage" box is checked so the NDB service will correctly finish cleaning up.