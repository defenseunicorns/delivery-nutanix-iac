output "vm_ips" {
  description = "IP addresses of the virtual machines."
  value       = [for vm in nutanix_virtual_machine.rke2_cluster : vm.nic_list_status.0.ip_endpoint_list[0]["ip"]]
}
