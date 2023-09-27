output "subnet_name" {
  description = "Name of the created subnet."
  value       = var.name
}

output "subnet_uuid" {
  description = "UUID of the created subnet."
  value       = nutanix_subnet.subnet.metadata.uuid
}
