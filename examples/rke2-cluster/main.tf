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
