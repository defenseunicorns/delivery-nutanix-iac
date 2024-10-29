# Copyright 2024 Defense Unicorns
# SPDX-License-Identifier: AGPL-3.0-or-later OR LicenseRef-Defense-Unicorns-Commercial

data "nutanix_cluster" "cluster" {
  name = var.nutanix_cluster
}

resource "nutanix_subnet" "subnet" {
  name         = var.name
  cluster_uuid = data.nutanix_cluster.cluster.id

  vlan_id     = var.vlan_id
  subnet_type = "VLAN"

  prefix_length = var.prefix_length

  default_gateway_ip = var.gateway_ip
  subnet_ip          = var.subnet_ip

  ip_config_pool_list_ranges = [var.ip_pool_range]

  dhcp_domain_name_server_list = var.dhcp_name_servers
  dhcp_domain_search_list      = var.dhcp_domain_search_list
}
