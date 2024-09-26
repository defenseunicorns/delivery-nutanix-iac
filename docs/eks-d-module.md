# EKS-D Module

This module depends on a Nutanix cluster already being configured with a subnet as well as an image being available that was built by the [eks-anywhere-image-builder-cli](https://anywhere.eks.amazonaws.com/docs/osmgmt/artifacts/). It also depends on an eks-management cluster already being configured which is where the module will create eksd-cluster resources. Instructions for creating an eks-management cluster in Nutanix can be followed [here](https://anywhere.eks.amazonaws.com/docs/getting-started/nutanix/nutanix-getstarted/).

An example set of variables passed to the module looks something like this:
```
  cluster_name = "example"
  control_plane_cert_sans = ["kube-example.your.hostname", "10.0.200.40"] # 10.0.200.40 used for example, but can be any static IP available for the control plane to use
  control_plane_host = "10.0.200.40"
  kube_version = "1.29"
  registry_mirror_host = "registry.mirror.host.address"
  registry_mirror_insecure = true
  prism_central_endpoint = "prism.central.host.address"
  prism_central_insecure = true
  nutanix_cluster_name = "YourNutanixClusterName"
  node_image_name = "eks-rhel-node-image-1.29-v2" # Node image name in prism image service. Must include the kube_version in the image name
  nutanix_subnet_name = "YourNutanixSubnetName"
  node_ssh_keys = ["ssh-rsa your ssh public key"]
  control_plane_count = 3
  etcd_node_count = 3
  compute_node_count = 3
  gitaly_dedicated_node_count = 1
  cp_node_memory = "16Gi"
  cp_node_cpu_count = 8
  etcd_node_memory = "8Gi"
  etcd_node_cpu_count = 4
  compute_node_memory = "64Gi"
  compute_node_cpu_count = 32
  gitaly_node_memory = "70Gi"
  gitaly_node_cpu_count = 20
```

This set of variables would configure the module to deploy 10 VMs into the subnet named "YourNutanixSubnetName" in the Nutanix cluster named "YourNutanixClusterName". 3 of the VMs would be configured as control plane nodes with 8 CPU and 16GiB of memory, 3 VMs would be configured as standalone etcd nodes with 4 CPU and 8GiB of memory, 3 VMs would be configured as compute nodes with 32 CPU and 64GiB of memory, and 1 VM would be configured as a compute node tainted for a dedicated Gitaly with 20 CPU and 70GiB of memory. The VMs would all be given names prefixed with "example" followed by a unique identifier. For example one of the control plane VM names might look like "example-87djw", and a compute node might look like "example-compute-lp7tt-4ks6w". By providing a list of SSH public keys to `node_ssh_keys` you will be able to SSH to any of the VMs using the user eksa and one of the SSH keys passed in.

All of the nodes created by EKS Anywhere will receive an IP via DHCP. Configure the `control_plane_host` and `control_plane_cert_sans` with an IP and (optionally) hostnames that will be used to access the control plane. The IP given should be static and not inside of the DHCP pool.

The `kube_version` variable tells EKS Anywhere what Kubernetes version to provision. The value set for this must be included in the VM image name passed to the `node_image_name` variable or EKS Anywhere will fail to validate the configuration and the cluster won't be created.

# Accessing the workload cluster

After the cluster nodes are deployed, the admin kubeconfig for the new cluster created can be found in the secrets in the management cluster managing the cluster. To get the kubeconfig for the cluster in this example and save it locally you could run this kubectl command on the management cluster: `kubectl get secret -n eksa-system example-kubeconfig -o jsonpath='{.data.value}' | base64 --decode > example.kubeconfig`

# Kubelet CSRs

Kubelet is configured to request signed certificates. This means that new nodes generate CSRs as they join the cluster that need approved manually. The following one liner can approve all CSRs in the cluster, but it doesn't distinguish Pending from already approved certs: `for cert in $(kubectl get csr -o custom-columns=":metadata.name"); do kubectl certificate approve $cert; done` If nodes joing after running the command there will be additional CSRs that need approved. Pending CSRs can be viewed with `kubectl get csr | grep Pending`

CSRs are regenerated any time a new node joins the cluster. This includes when a node rollout is performed for a scale out or node upgrade or if a node is recreated for some reason.

# Cilium Configuration

By default Cilium does not support netpols that select in cluster resources by IP addresses. This includes netpols that grant access to node IPs for API access such as needed by metrics-server. To work with UDS deployments, the cilium config must be updated after the cluster is up to enable a feature flag that allows selecting nodes by IPs. This setting is not currently exposed via the cluster resource used by EKS Anywhere so it must be done in cluster after deployment.

Run `kubectl edit configmap cilium-config -n kube-system` and set the following option `policy-cidr-match-mode: nodes`. Then perform a rollout on the cilium operator deployment and cilium daemonset to ensure the setting goes into affect. This setting should persist through cluster upgrades and rollouts so it should only need done one time for a new cluster.

# Cluster Upgrades/Scaling

A cluster created with this module can have values updated and applied with tofu and EKS Anywhere will automatically scale out for horizontal scaling and perform node rollouts for both cluster upgrades and vertical scaling.

## Additional Scaling Notes

When performing node rollouts eksa can get stuck deleting a node that has been marked as unschedulable even after its replacement is ready. This seems to be related to pods that aren't terminated successfully on the node. To unblock the rollout, deleting the pods that are still running on the node should allow it to proceed with deleting the node.

EKS-A docs on cluster scaling vertically is invalid. Memory and vcpu are immutable fields in NutanixMachineConfig resources. Have to delete the resource, recreate it with desired values, and then do an upgrade. Terraform/tofu might handle this automatically, but haven't tested it yet.
