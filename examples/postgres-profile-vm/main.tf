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

module "postgres-14-profile-vm" {
  source = "../modules/postgres-profile-vm"

  nutanix_cluster     = "Your-Cluster"
  nutanix_subnet      = "Your Subnet"
  name                = "postgres-14-profile"
  memory              = 16 * 1024
  image_name          = "uds-postgresql-14-some-build-tag"
  ssh_authorized_keys = var.ssh_authorized_keys
  user_password       = var.user_password
  pg_password         = var.pg_password
}
