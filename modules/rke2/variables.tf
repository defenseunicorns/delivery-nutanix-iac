variable "nutanix_cluster" {
  description = "The name of the Nutanix cluster to deploy to."
  type        = string
}

variable "nutanix_subnet" {
  description = "The name of the subnet to deploy VMs to."
  type        = string
}

variable "server_ip_list" {
  description = "The list of IPs for server nodes. List must be >= server_count."
  type        = list(string)
  default     = []
}

variable "server_dns_name" {
  description = "The DNS name to use for the server/controlplane. Should route round robin to all IPs under server_ip_list. Required if bootstrap_cluster is set to false."
  type        = string
  default     = ""
}

variable "name" {
  description = "Name to use for VMs and other resources."
  type        = string
  default     = "rke2"
}

variable "unique_suffix" {
  description = "Whether to add a unique suffix to the name."
  type        = bool
  default     = true
}

variable "boot_type" {
  description = "Boot type for cluster VMs. Valid options are UEFI, LEGACY, or SECURE_BOOT. UEFI is preferred."
  type        = string
  default     = "UEFI"
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
  default     = 1
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
  default     = 1
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

variable "agent_primary_disk_size" {
  description = "The size of the primary disk for agent VMs in MiB. Primary disk is the boot disk and contains ephemeral storage."
  type        = number
  default     = 150 * 1024
}

variable "ssh_authorized_keys" {
  description = "A list of authorized public SSH keys to allow for login to the nutanix user on all nodes"
  type        = list(string)
}

variable "node_user" {
  description = "The username to use for the default user on cluster node hosts."
  type        = string
  default     = "nutanix"
}

variable "join_token" {
  description = "Secret used for a node to join the cluster."
  type        = string
}

variable "bootstrap_cluster" {
  description = "Should module bootstrap a new cluster, or should nodes join an existing cluster? If this is false, then server_dns_name must be set for nodes to join a cluster."
  type        = bool
}

variable "taint_servers" {
  description = "Should taints be applied to server nodes to prevent workloads from scheduling on them?"
  type        = bool
  default     = true
}
