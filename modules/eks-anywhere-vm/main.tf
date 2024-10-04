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

resource "nutanix_virtual_machine" "eks_anywhere_vm" {
  name         = "${random_string.uid.result}-eks-anywhere-admin"
  cluster_uuid = data.nutanix_cluster.cluster.id

  memory_size_mib      = 16 * 1024
  num_sockets          = 4
  num_vcpus_per_socket = 1

  boot_type = "UEFI"

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
    disk_size_mib = 150 * 1024
  }

  nic_list {
    subnet_uuid = data.nutanix_subnet.subnet.id
  }

  guest_customization_cloud_init_user_data = base64encode(templatefile("${path.module}/cloud-config.tpl.yaml", {
    hostname         = "${random_string.uid.result}-eks-anywhere-admin",
    node_user        = "nutanix",
    authorized_keys  = var.ssh_authorized_keys,
    ntp_server       = var.ntp_server,
    registry_mirror  = "${var.registry_mirror_host}:${var.registry_mirror_port}",
    nutanix_username = var.nutanix_username,
    nutanix_password = var.nutanix_password
  }))
}
