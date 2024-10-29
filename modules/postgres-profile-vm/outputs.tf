# Copyright 2024 Defense Unicorns
# SPDX-License-Identifier: AGPL-3.0-or-later OR LicenseRef-Defense-Unicorns-Commercial

output "bootstrap_ip" {
  description = "IP address for the bootstrap virtual machines."
  value       = nutanix_virtual_machine.postgres_profile_vm.nic_list_status[0].ip_endpoint_list[0]["ip"]
}
