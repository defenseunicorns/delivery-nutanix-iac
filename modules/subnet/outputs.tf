# Copyright 2024 Defense Unicorns
# SPDX-License-Identifier: AGPL-3.0-or-later OR LicenseRef-Defense-Unicorns-Commercial

output "subnet_name" {
  description = "Name of the created subnet."
  value       = var.name
}

output "subnet_uuid" {
  description = "UUID of the created subnet."
  value       = nutanix_subnet.subnet.metadata.uuid
}
