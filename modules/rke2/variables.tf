variable "nutanix_username" {
  description = "The username used to authenticate with Prism Central."
  type        = string
}

variable "nutanix_password" {
  description = "The password used to authenticate with Prism Central."
  type        = string
}

variable "nutanix_endpoint" {
  description = "The endpoint URL for Prism Central."
  type        = string
}

variable "nutanix_port" {
  description = "The port to use when connecting to Prism Central."
  type        = number
  default     = 9440
}

variable "nutanix_insecure" {
  description = "Set to true to disable SSL certificate validation, false by default."
  type        = bool
  default     = false
}

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
  default     = "rke2-server"
}

variable "unique_suffix" {
  description = "Whether to add a unique suffix to the name."
  type        = bool
  default     = true
}

variable "server_count" {
  description = "The number of server VMs to deploy."
  type        = number
  default     = 3
}

variable "agent_count" {
  description = "The number of agent VMs to deploy."
  type        = number
  default     = 6
}


variable "server_memory" {
  description = "The amount of memory for each server VM in MiB."
  type        = number
}

variable "server_cpu" {
  description = "The number of CPUs for each server VM."
  type        = number
}

variable "server_cpu_cores" {
  description = "The number of CPU cores, per CPU, for each server VM."
  type        = number
  default = 1
}

variable "agent_memory" {
  description = "The amount of memory for each agent VM in MiB."
  type        = number
}

variable "agent_cpu" {
  description = "The number of CPUs for each agent VM."
  type        = number
}

variable "agent_cpu_cores" {
  description = "The number of CPU cores, per CPU, for each agent VM."
  type        = number
  default = 1
}

variable "image_name" {
  description = "The name of the image to use for virtual machines."
  type        = string
}

variable "server_primary_disk_size" {
  description = "The size of the primary disk for server VMs in MiB. Primary disk is the boot disk and contains ephemeral storage."
  type        = number
  default     = 150 * 1024
}

variable "server_secondary_disk_size" {
  description = "The size of the secondary disk for server VMs in MiB. Secondary disk is used for PVC/object storage with rook/ceph."
  type        = number
  default     = 300 * 1024
}

variable "agent_primary_disk_size" {
  description = "The size of the primary disk for agent VMs in MiB. Primary disk is the boot disk and contains ephemeral storage."
  type        = number
  default     = 150 * 1024
}

variable "agent_secondary_disk_size" {
  description = "The size of the secondary disk for agent VMs in MiB. Secondary disk is used for PVC/object storage with rook/ceph."
  type        = number
  default     = 300 * 1024
}

variable "ssh_authorized_keys" {
  description = "A list of authorized public SSH keys to allow for login to the nutanix user on all nodes"
  type        = list(string)
}
