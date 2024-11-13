# Copyright 2024 Defense Unicorns
# SPDX-License-Identifier: AGPL-3.0-or-later OR LicenseRef-Defense-Unicorns-Commercial

terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.32.0"
    }
  }
  backend "s3" {
    bucket    = "tofu-state"
    key       = "eks-example-cluster/terraform.tfstate"
    endpoints = { s3 = "https://some.object.store.come" }
    region    = "us-east-1"

    shared_credentials_files    = ["~/.nutanix/credentials"]
    insecure                    = true
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_s3_checksum            = true
  }
}

# Set TF_VAR_kubeconfig to select the kubeconfig to use for the provider
provider "kubernetes" {
  config_path = var.kubeconfig
}

module "eksa-example-cluster" {
  source = "../../modules/eks-d"

  cluster_name             = "example"
  control_plane_cert_sans  = ["kube-example.your.hostname", "10.0.200.40"] # 10.0.200.40 used for example, but can be any static IP available for the control plane to use
  control_plane_host       = "10.0.200.40"
  kube_version             = "1.29"
  registry_mirror_host     = "registry.mirror.host.address"
  registry_mirror_insecure = true
  prism_central_endpoint   = "prism.central.host.address"
  prism_central_insecure   = true
  nutanix_cluster_name     = "YourNutanixClusterName"
  node_image_name          = "eks-rhel-node-image-1.29-v2" # Node image name in prism image service. Must include the kube_version in the image name
  nutanix_subnet_name      = "YourNutanixSubnetName"
  node_ssh_keys            = ["ssh-rsa your ssh public key"]
  # Example resources given. Scale to your needs. This example uses default values for node counts, but those can also be scaled
  cp_node_memory         = "16Gi"
  cp_node_cpu_count      = 8
  etcd_node_memory       = "8Gi"
  etcd_node_cpu_count    = 4
  compute_node_memory    = "64Gi"
  compute_node_cpu_count = 32
  gitaly_node_memory     = "70Gi"
  gitaly_node_cpu_count  = 20
}
