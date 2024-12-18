# Copyright 2024 Defense Unicorns
# SPDX-License-Identifier: AGPL-3.0-or-later OR LicenseRef-Defense-Unicorns-Commercial

variable "nutanix_cluster" {
  description = "The name of the Nutanix cluster to deploy to."
  type        = string
}

variable "name" {
  description = "Name to use for subnet."
  type        = string
}

variable "vlan_id" {
  description = "VLAN ID for the subnet, ex: 101"
  type        = number
}

variable "gateway_ip" {
  description = "The default gateway IP for the subnet, ex: 192.168.101.1"
  type        = string
  default     = ""
}

variable "prefix_length" {
  description = "The prefix length of the subnet, ex: 24"
  type        = number
  default     = 24
}

variable "subnet_ip" {
  description = "The subnet IP for the subnet, ex: 192.168.101.0"
  type        = string
  default     = ""
}

variable "ip_pool_range" {
  description = "The IP pool for the subnet, space delimited starting and ending IP, ex: 192.168.101.100 192.168.101.200"
  type        = string
  default     = ""
}

variable "dhcp_name_servers" {
  description = "List of DHCP domain name servers"
  type        = list(string)
  default     = []
}

variable "dhcp_domain_search_list" {
  description = "List of DHCP domain search list"
  type        = list(string)
  default     = []
}
