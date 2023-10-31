locals {
  uname = var.unique_suffix ? lower("${var.name}-${random_string.uid.result}") : lower(var.name)
}

resource "random_string" "uid" {
  length  = 3
  special = false
  lower   = true
  upper   = false
  numeric = true
}

data "nutanix_cluster" "cluster" {
  name = var.nutanix_cluster
}

data "nutanix_subnet" "subnet" {
  subnet_name = var.nutanix_subnet
}

data "nutanix_image" "image" {
  image_name = var.image_name
}

resource "nutanix_virtual_machine" "postgres_profile_vm" {
  name         = local.uname
  cluster_uuid = data.nutanix_cluster.cluster.id

  memory_size_mib      = var.memory
  num_sockets          = var.cpu
  num_vcpus_per_socket = var.cpu_cores

  disk_list {
    data_source_reference = {
      kind = "image"
      uuid = data.nutanix_image.image.id
    }
    device_properties {
      disk_address = {
        device_index = 0
        adapter_type = "SCSI"
      }
      device_type = "DISK"
    }
    disk_size_mib = var.os_disk_size
  }
  disk_list {
    disk_size_mib = var.data_disk_size
  }

  nic_list {
    subnet_uuid = data.nutanix_subnet.subnet.id
  }

  guest_customization_cloud_init_user_data = base64encode(templatefile("${path.module}/cloud-config.tpl.yaml", {
    hostname         = "${local.uname}-server-0",
    authorized_keys  = var.ssh_authorized_keys,
    user_password    = var.user_password,
    pg_password      = var.pg_password,
    postgres_version = var.postgres_version
  }))
}
