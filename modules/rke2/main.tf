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

// resource "random_password" "token" {
//   length  = 40
//   special = false
// }

data "nutanix_cluster" "cluster" {
  name = var.nutanix_cluster
}

data "nutanix_subnet" "subnet" {
  subnet_name = var.nutanix_subnet
}

data "nutanix_image" "image" {
  image_name = var.image_name
}

resource "nutanix_virtual_machine" "rke2_cluster" {
  count        = var.server_count
  name         = "${local.uname}-${count.index}"
  cluster_uuid = data.nutanix_cluster.cluster.id

  memory_size_mib      = var.instance_memory
  num_vcpus_per_socket = var.instance_cpu
  num_sockets          = 1

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
    disk_size_mib = var.primary_disk_size
  }
  disk_list {
    disk_size_mib = var.secondary_disk_size
  }

  nic_list {
    subnet_uuid = data.nutanix_subnet.subnet.id
  }

  guest_customization_cloud_init_user_data = base64encode(templatefile("./userdata.tpl.yaml", {
    count           = count.index,
    uname           = local.uname,
    authorized_keys = var.ssh_authorized_keys
  }))
}
