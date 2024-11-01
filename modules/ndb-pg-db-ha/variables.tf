#NDB settings

variable "software_profile_name" {
  description = "The name of the software profile in NDB to use for the DB. Uses the latest published version of the profile. Ex: 'postgres-14.9'"
  type        = string
}

variable "compute_profile_name" {
  description = "The name of the compute profile in NDB to use for the DB. Ex: large-compute"
  type        = string
}

variable "network_profile_name" {
  description = "The name of the network profile in NDB to use for the DB. Ex: DEFAULT_OOB_POSTGRESQL_NETWORK"
  type        = string
}

variable "db_param_profile_name" {
  description = "The name of the database parameter profile in NDB to use for the DB. Ex: DEFAULT_POSTGRES_PARAMS"
  type        = string
}

variable "sla_name" {
  description = "The name of the time machine SLA in NDB to use for the DB. Ex: DEFAULT_OOB_BRASS_SLA"
  type        = string
}

#Database settings

variable "database_name" {
  description = "Name to use for postgres DB created during provisioning."
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "The password to set for the postgres DB postgres user."
  type        = string
}

variable "database_size" {
  description = "The size in GiB to give for postgres data."
  type        = string
}

# VM settings

variable "instance_name" {
  description = "Name used as a prefix for the postgres instance, VM, and time machine names."
  type        = string
}

variable "node_count" {
  description = "How many postgres nodes to create in an HA cluster"
  type        = number
}

variable "deploy_haproxy" {
  description = "Should HA proxy be deployed?"
  type        = bool
}

variable "unique_suffix" {
  description = "Whether to add a unique suffix to the instance_name for the VM, postgres instance, and time machine names. Not added to the database_name."
  type        = bool
  default     = true
}

variable "nutanix_cluster_name" {
  description = "The name of the Nutanix cluster to deploy to."
  type        = string
}

variable "ssh_authorized_key" {
  description = "An SSH public key to allow for login to the era user on postgres databases"
  type        = string
}

variable "vm_password" {
  description = "The password to set for the VM era user."
  type        = string
  default     = null
}
