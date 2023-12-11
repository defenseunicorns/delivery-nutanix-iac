output "bootstrap_ip" {
  description = "IP address for the bootstrap virtual machines."
  value       = length(nutanix_virtual_machine.rke2_bootstrap) > 0 ? nutanix_virtual_machine.rke2_bootstrap[0].nic_list_status.0.ip_endpoint_list[0]["ip"] : null
}
