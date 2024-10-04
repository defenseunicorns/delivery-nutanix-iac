# Only needed if an external registry already exists to host an eks-d registry mirror. Will be added to docker insecure-registries for bootstrapping the management cluster
variable "registry_mirror_host" {
  description = "The hostname/IP of the eks-d registry mirror to use for an airgap cluster installation."
  type        = string
  default     = ""
}

variable "registry_mirror_port" {
  description = "The port used by the registry mirror to serve eks-d images."
  type        = string
  default     = ""
}

variable "nutanix_cluster" {
  description = "The name of the Nutanix cluster to deploy the eks-d cluster into."
  type        = string
}

variable "image_name" {
  description = "The name of the eks anywhwere image to use to create an eks-anywhere VM. This VM is used to bootstrap an eks-anywhere management cluster."
  type        = string
}

variable "nutanix_subnet" {
  description = "Nutanix subnet name to deploy cluster into."
  type        = string
}

variable "ssh_authorized_keys" {
  description = "A list of authorized public SSH keys to allow for login to the nutanix user on all nodes"
  type        = list(string)
}

variable "ntp_server" {
  description = "IP or hostname of NTP server to use for host"
  type        = string
  default     = ""
}

variable "nutanix_username" {
  description = "Prism Central username used by eks anywhere to provision VMs"
  type        = string
  default     = ""
}

variable "nutanix_password" {
  description = "Prism Central password used by eks anywhere to provision VMs"
  type        = string
  default     = ""
}
