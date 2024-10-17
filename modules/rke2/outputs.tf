# Copyright 2024 Defense Unicorns
# SPDX-License-Identifier: AGPL-3.0-or-later OR LicenseRef-Defense-Unicorns-Commercial

output "bootstrap_ip" {
  description = "IP address for the bootstrap virtual machines."
  value       = length(nutanix_virtual_machine.rke2_bootstrap) > 0 ? nutanix_virtual_machine.rke2_bootstrap[0].nic_list_status.0.ip_endpoint_list[0]["ip"] : null
}
