variable "nutanix_cluster" {
  description = "The name of the Nutanix cluster to deploy to."
  type        = string
}

variable "nutanix_subnet" {
  description = "The name of the subnet to deploy VMs to."
  type        = string
}

variable "name" {
  description = "Name to use for VMs and other resources."
  type        = string
  default     = "postgres-profile"
}

variable "unique_suffix" {
  description = "Whether to add a unique suffix to the name."
  type        = bool
  default     = true
}

variable "memory" {
  description = "The amount of memory for each server VM in MiB."
  type        = number
}

variable "cpu" {
  description = "The number of CPUs for each server VM."
  type        = number
  default     = 1
}

variable "cpu_cores" {
  description = "The number of CPU cores, per CPU, for each server VM."
  type        = number
  default     = 4
}

variable "image_name" {
  description = "The name of the image to use for virtual machines."
  type        = string
}

variable "os_disk_size" {
  description = "The size of the primary disk for server VMs in MiB. Primary disk is the boot disk and contains ephemeral storage."
  type        = number
  default     = 20 * 1024
}

variable "data_disk_size" {
  description = "The size of the secondary disk for server VMs in MiB. Secondary disk is used for postgres data."
  type        = number
  default     = 50 * 1024
}

# Cloud init variables
variable "ssh_authorized_keys" {
  description = "A list of authorized public SSH keys to allow for login to the nutanix user on all nodes"
  type        = list(string)
}

variable "user_password" {
  description = "The password to set for the era user."
  type        = string
}

variable "pg_password" {
  description = "The password to set for the postgres DB postgres user. This can be anything, but the value needs to be provided to NDB on DB import."
  type        = string
}

variable "postgres_version" {
  description = "Major version of postgres."
  type        = string
  default     = "14"
}
