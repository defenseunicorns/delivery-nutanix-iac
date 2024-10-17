# Copyright 2024 Defense Unicorns
# SPDX-License-Identifier: AGPL-3.0-or-later OR LicenseRef-Defense-Unicorns-Commercial

variable "cluster_name" {
  description = "The name of the eks-d cluster being created."
  type        = string
}

variable "namespace" {
  description = "The namespace to create eks anywhere resources in the management cluster."
  type        = string
  default     = "default"
}

variable "control_plane_cert_sans" {
  description = "IP and DNS SANs to add to kube-api certificates. Typically should include a hostname and/or the value you set for control_plane_host."
  type        = list(string)
}

variable "control_plane_count" {
  description = "The number of compute nodes to create. Defaults to 3 for an HA control plane."
  type        = number
  default     = 3
}

variable "control_plane_host" {
  description = "The DNS name or IP address to use for the server/controlplane. This is independent of the IPs that get assigned to control plane nodes via DHCP and if an IP is used it should be outside of the DHCP range."
  type        = string
}

variable "etcd_node_count" {
  description = "The number of etcd nodes to create. Defaults to 3 for HA etcd."
  type        = number
  default     = 3
}

variable "kube_version" {
  description = "What version of kubernetes to deploy. The version chosen must be included in the name of the node_image being used. Example 1.29"
  type        = string
}

variable "management_cluster_name" {
  description = "Name of the eks-d management cluster that has eka-anywhere configured and is used to manage workload clusters. Default is based on example management cluster from eks-anywhere docs."
  type        = string
  default     = "mgmt"
}

variable "registry_mirror_ca_cert" {
  description = "CA cert used to sign the cert served by the eks-d registry mirror. If this isn't provided, then registry_mirror_insecure must be set to true."
  type        = string
  default     = null
}

variable "registry_mirror_host" {
  description = "The hostname/IP of the eks-d registry mirror to use for an airgap cluster installation."
  type        = string
  default     = null
}

variable "registry_mirror_insecure" {
  description = "Set to true if TLS verification should be skipped for the registry mirror."
  type        = bool
  default     = false
}

variable "registry_mirror_port" {
  description = "The port used by the registry mirror to serve eks-d images."
  type        = string
  default     = "5000"
}

variable "compute_node_count" {
  description = "The number of compute nodes to create."
  type        = number
  default     = 3
}

variable "gitaly_dedicated_node_count" {
  description = "The number of dedicated gitaly nodes to create."
  type        = number
  default     = 1
}

variable "prism_central_endpoint" {
  description = "IP or hostname of Prism Central."
  type        = string
}

variable "prism_central_insecure" {
  description = "If TLS verification for the prism central endpoint should be disabled."
  type        = bool
  default     = false
}

variable "prism_central_port" {
  description = "The port used to connect to Prism Central."
  type        = string
  default     = "9440"
}

variable "nutanix_cluster_name" {
  description = "The name of the Nutanix cluster to deploy the eks-d cluster into."
  type        = string
}

variable "node_image_name" {
  description = "The name of the eks node image to use to create eks-d node VMs. Must include the kube_version in the name. Example eks-rhel-node-image-1.29"
  type        = string
}

variable "cp_node_memory" {
  description = "Amount of memory to set for each control plane node. Defaults are for example only and should be scaled based on workload."
  type        = string
  default     = "4Gi"
}

variable "node_os_family" {
  description = "OS family used by node image. Valid options are redhat or ubuntu for Nutanix."
  type        = string
  default     = "redhat"
}

variable "nutanix_subnet_name" {
  description = "Nutanix subnet name to deploy cluster into."
  type        = string
}

variable "cp_system_disk_size" {
  description = "Amount of storage to configure for each control plane node host disk."
  type        = string
  default     = "40Gi"
}

variable "node_ssh_keys" {
  description = "List of SSH keys to allow eksa user to access the VMs deployed for all cluster nodes."
  type        = list(string)
}

variable "cp_node_cpu_count" {
  description = "Number of CPU that should be allocated for each control plane node. Default value is for example only and should be scaled based on workload."
  type        = number
  default     = 4
}

variable "etcd_node_memory" {
  description = "Amount of memory to set for each etcd node. Defaults are for example only and should be scaled based on workload."
  type        = string
  default     = "4Gi"
}

variable "etcd_system_disk_size" {
  description = "Amount of storage to configure for each etcd node host disk."
  type        = string
  default     = "40Gi"
}

variable "etcd_node_cpu_count" {
  description = "Number of CPU that should be allocated for each etcd node. Default value is for example only and should be scaled based on workload."
  type        = number
  default     = 4
}

variable "compute_node_memory" {
  description = "Amount of memory to set for each compute node. Defaults are for example only and should be scaled based on workload."
  type        = string
  default     = "4Gi"
}

variable "compute_system_disk_size" {
  description = "Amount of storage to configure for each compute node host disk."
  type        = string
  default     = "40Gi"
}

variable "compute_node_cpu_count" {
  description = "Number of CPU that should be allocated for each compute node. Default value is for example only and should be scaled based on workload."
  type        = number
  default     = 4
}

variable "gitaly_node_memory" {
  description = "Amount of memory to set for each dedicated gitaly node. Defaults are for example only and should be scaled based on workload."
  type        = string
  default     = "4Gi"
}

variable "gitaly_system_disk_size" {
  description = "Amount of storage to configure for each dedicated gitaly node host disk."
  type        = string
  default     = "40Gi"
}

variable "gitaly_node_cpu_count" {
  description = "Number of CPU that should be allocated for each dedicated gitaly node. Default value is for example only and should be scaled based on workload."
  type        = number
  default     = 4
}
