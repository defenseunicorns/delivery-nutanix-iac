# Copyright 2024 Defense Unicorns
# SPDX-License-Identifier: AGPL-3.0-or-later OR LicenseRef-Defense-Unicorns-Commercial


terraform {
  required_providers {
    nutanix = {
      source  = "nutanix/nutanix"
      version = ">= 1.9.0"
    }
  }
}

provider "nutanix" {
  username = var.nutanix_username
  password = var.nutanix_password
  endpoint = var.nutanix_endpoint
  port     = var.nutanix_port
  insecure = var.nutanix_insecure
}

resource "random_password" "example_token" {
  length  = 40
  special = false
}

# This example shows how you would create a cluster with 3 server nodes and 6 agent nodes, 3 of which have no taints for regular workloads, and 3 of which have taints to prevent scheduling so they are reserved for running gitaly

# Deploy cluster without custom taints
module "example-cluster" {
  source = "../modules/rke2"

  nutanix_cluster     = "Your-Cluster"
  nutanix_subnet      = "Your Subnet"
  name                = "example-rke2"
  server_count        = 3
  agent_count         = 3
  server_memory       = 16 * 1024
  server_cpu          = 8
  agent_memory        = 32 * 1024
  agent_cpu           = 16
  image_name          = "uds-rke2-rhel-some-build-tag"
  ssh_authorized_keys = var.ssh_authorized_keys
  server_dns_name     = "example-rke2.your-domain.com"
  join_token          = random_password.example_token.result
  bootstrap_cluster   = true
}

# Deploy and join additional agent nodes with custom taints to be used by gitaly
module "gitaly-nodes" {
  source = "../modules/rke2"

  nutanix_cluster     = "Your-Cluster"
  nutanix_subnet      = "Your Subnet"
  name                = "example-gitaly-rke2"
  server_count        = 0
  agent_count         = 3
  server_memory       = 16 * 1024
  server_cpu          = 8
  agent_memory        = 32 * 1024
  agent_cpu           = 16
  image_name          = "uds-rke2-rhel-some-build-tag"
  ssh_authorized_keys = var.ssh_authorized_keys
  server_dns_name     = "example-rke2.your-domain.com"
  join_token          = random_password.example_token.result
  bootstrap_cluster   = false
  agent_custom_taints = ["gitaly-node=:NoSchedule"]
}
