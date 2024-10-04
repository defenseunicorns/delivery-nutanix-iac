resource "kubernetes_manifest" "cluster" {
  computed_fields = ["metadata.generation", "metadata.annotations", "metadata.labels"]
  field_manager {
    force_conflicts = true
  }

  manifest = {
    "apiVersion" = "anywhere.eks.amazonaws.com/v1alpha1"
    "kind" = "Cluster"
    "metadata" = {
      "name" = var.cluster_name
      "namespace" = var.namespace
    }
    "spec" = {
      "clusterNetwork" = {
        "cniConfig" = {
          "cilium" = {}
        }
        "pods" = {
          "cidrBlocks" = [
            "192.168.0.0/16",
          ]
        }
        "services" = {
          "cidrBlocks" = [
            "10.96.0.0/12",
          ]
        }
      }
      "controlPlaneConfiguration" = {
        "certSans" = var.control_plane_cert_sans
        "count" = var.control_plane_count
        "endpoint" = {
          "host" = var.control_plane_host
        }
        "kubeletConfiguration" = {
          "kind" = "KubeletConfiguration"
          "rotateCertificates" = true
          "serverTLSBootstrap" = true
          "tlsCipherSuites" = [
            "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256"
          ]
        }
        "machineGroupRef" = {
          "kind" = "NutanixMachineConfig"
          "name" = "${var.cluster_name}-cp"
        }
        "taints" = [
          {
            "effect" = "NoSchedule"
            "key" = "node-role.kubernetes.io/control-plane"
          },
        ]
      }
      "datacenterRef" = {
        "kind" = "NutanixDatacenterConfig"
        "name" = var.cluster_name
      }
      "externalEtcdConfiguration" = {
        "count" = var.etcd_node_count
        "machineGroupRef" = {
          "kind" = "NutanixMachineConfig"
          "name" = "${var.cluster_name}-etcd"
        }
      }
      "kubernetesVersion" = var.kube_version
      "managementCluster" = {
        "name" = var.management_cluster_name
      }
      "registryMirrorConfiguration" = {
        "caCertContent" = var.registry_mirror_ca_cert
        "endpoint" = var.registry_mirror_host
        "insecureSkipVerify" = var.registry_mirror_insecure
        "port" = var.registry_mirror_port
      }
      "workerNodeGroupConfigurations" = [
        {
          "count" = var.compute_node_count
          "kubeletConfiguration" = {
            "kind" = "KubeletConfiguration"
            "rotateCertificates" = true
            "serverTLSBootstrap" = true
            "tlsCipherSuites" = [
            "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256"
          ]
          }
          "machineGroupRef" = {
            "kind" = "NutanixMachineConfig"
            "name" = "${var.cluster_name}-compute"
          }
          "name" = "compute"
        },
        {
          "count" = var.gitaly_dedicated_node_count
          "kubeletConfiguration" = {
            "kind" = "KubeletConfiguration"
            "rotateCertificates" = true
            "serverTLSBootstrap" = true
            "tlsCipherSuites" = [
            "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256"
          ]
          }
          "machineGroupRef" = {
            "kind" = "NutanixMachineConfig"
            "name" = "${var.cluster_name}-gitaly"
          }
          "name" = "compute-gitaly"
          "taints" = [
            {
              "effect" = "NoSchedule"
              "key" = "dedicated-gitaly-node"
            },
          ]
        },
      ]
    }
  }
}

resource "kubernetes_manifest" "nutanixdatacenterconfig" {
  manifest = {
    "apiVersion" = "anywhere.eks.amazonaws.com/v1alpha1"
    "kind" = "NutanixDatacenterConfig"
    "metadata" = {
      "name" = var.cluster_name
      "namespace" = var.namespace
    }
    "spec" = {
      "credentialRef" = {
        "kind" = "Secret"
        "name" = "nutanix-credentials"
      }
      "endpoint" = var.prism_central_endpoint
      "insecure" = var.prism_central_insecure
      "port" = var.prism_central_port
    }
  }
}

resource "kubernetes_manifest" "nutanixmachineconfig_control_plane" {
  manifest = {
    "apiVersion" = "anywhere.eks.amazonaws.com/v1alpha1"
    "kind" = "NutanixMachineConfig"
    "metadata" = {
      "name" = "${var.cluster_name}-cp"
      "namespace" = var.namespace
    }
    "spec" = {
      "cluster" = {
        "name" = var.nutanix_cluster_name
        "type" = "name"
      }
      "image" = {
        "name" = var.node_image_name
        "type" = "name"
      }
      "memorySize" = var.cp_node_memory
      "osFamily" = var.node_os_family
      "subnet" = {
        "name" = var.nutanix_subnet_name
        "type" = "name"
      }
      "systemDiskSize" = var.cp_system_disk_size
      "users" = [
        {
          "name" = "eksa"
          "sshAuthorizedKeys" = var.node_ssh_keys
        },
      ]
      "vcpuSockets" = var.cp_node_cpu_count
      "vcpusPerSocket" = 1
    }
  }
}

resource "kubernetes_manifest" "nutanixmachineconfig_etcd" {
  manifest = {
    "apiVersion" = "anywhere.eks.amazonaws.com/v1alpha1"
    "kind" = "NutanixMachineConfig"
    "metadata" = {
      "name" = "${var.cluster_name}-etcd"
      "namespace" = var.namespace
    }
    "spec" = {
      "cluster" = {
        "name" = var.nutanix_cluster_name
        "type" = "name"
      }
      "image" = {
        "name" = var.node_image_name
        "type" = "name"
      }
      "memorySize" = var.etcd_node_memory
      "osFamily" = var.node_os_family
      "subnet" = {
        "name" = var.nutanix_subnet_name
        "type" = "name"
      }
      "systemDiskSize" = var.etcd_system_disk_size
      "users" = [
        {
          "name" = "eksa"
          "sshAuthorizedKeys" = var.node_ssh_keys
        },
      ]
      "vcpuSockets" = var.etcd_node_cpu_count
      "vcpusPerSocket" = 1
    }
  }
}

resource "kubernetes_manifest" "nutanixmachineconfig_compute" {
  manifest = {
    "apiVersion" = "anywhere.eks.amazonaws.com/v1alpha1"
    "kind" = "NutanixMachineConfig"
    "metadata" = {
      "name" = "${var.cluster_name}-compute"
      "namespace" = var.namespace
    }
    "spec" = {
      "cluster" = {
        "name" = var.nutanix_cluster_name
        "type" = "name"
      }
      "image" = {
        "name" = var.node_image_name
        "type" = "name"
      }
      "memorySize" = var.compute_node_memory
      "osFamily" = var.node_os_family
      "subnet" = {
        "name" = var.nutanix_subnet_name
        "type" = "name"
      }
      "systemDiskSize" = var.compute_system_disk_size
      "users" = [
        {
          "name" = "eksa"
          "sshAuthorizedKeys" = var.node_ssh_keys
        },
      ]
      "vcpuSockets" = var.compute_node_cpu_count
      "vcpusPerSocket" = 1
    }
  }
}

resource "kubernetes_manifest" "nutanixmachineconfig_gitaly" {
  manifest = {
    "apiVersion" = "anywhere.eks.amazonaws.com/v1alpha1"
    "kind" = "NutanixMachineConfig"
    "metadata" = {
      "name" = "${var.cluster_name}-gitaly"
      "namespace" = var.namespace
    }
    "spec" = {
      "cluster" = {
        "name" = var.nutanix_cluster_name
        "type" = "name"
      }
      "image" = {
        "name" = var.node_image_name
        "type" = "name"
      }
      "memorySize" = var.gitaly_node_memory
      "osFamily" = var.node_os_family
      "subnet" = {
        "name" = var.nutanix_subnet_name
        "type" = "name"
      }
      "systemDiskSize" = var.gitaly_system_disk_size
      "users" = [
        {
          "name" = "eksa"
          "sshAuthorizedKeys" = var.node_ssh_keys
        },
      ]
      "vcpuSockets" = var.gitaly_node_cpu_count
      "vcpusPerSocket" = 1
    }
  }
}
