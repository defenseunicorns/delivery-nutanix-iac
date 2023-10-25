output "bootstrap_ip" {
  description = "IP address for the bootstrap virtual machines."
  value       = nutanix_virtual_machine.postgres_profile_vm.nic_list_status.0.ip_endpoint_list[0]["ip"]
}
