# RKE2 Module

This module depends on a Nutanix cluster already being configured with a subnet as well as an image being available that was built by the [uds-rke2-image-builder](https://github.com/defenseunicorns/uds-rke2-image-builder). Images built by that repo contain all needed RKE2 dependencies and the rke2 startup script that this module expects to be available that handles configuring, starting, and joining RKE2 nodes.

An example set of variables passed to the module looks something like this:
```
nutanix_cluster     = "Your-Cluster"
nutanix_subnet      = "Your Subnet"
name                = "example-rke2"
server_count        = 3
agent_count         = 3
server_memory       = 16 * 1024
server_cpu          = 8
agent_memory        = 32 * 1024
agent_cpu           = 16
image_name          = "uds-rke2-rhel-some-build-tag"
ssh_authorized_keys = ["ssh-rsa rest of your key here", "ssh-rsa different key here"]
server_dns_name     = "example-rke2.your-domain.com"
join_token          = random_password.example_token.result
bootstrap_cluster   = true
```

This set of variables would configure the module to deploy 6 VMs into the subnet named "Your Subnet" in the Nutanix cluster named "Your-Cluster". 3 of the VMs would be configured as RKE2 control plane nodes with 8 CPU and 16GiB of memory, and the other 3 VMs would be configured as agent nodes with 16 CPU and 32GiB of memory. The VMs would all be given names prefixed with "example-rke2" followed by a unique identifier and a count. For example the control plane VM names might look like "example-rke2-abc-server-0", "example-rke2-abc-server-1", etc. This would also configure each VM to allow signing in with either of the SSH keys added to the ssh_authorized_keys list. The current cloud-config configures all VMs with a default user named `nutanix` that can only log in with one of the SSH keys provided.

The `server_dns_name` variable configures both the hostname used by nodes to join the cluster, and should be set to the hostname you want to use to access the kube-api. This hostname is added as a TLS SAN to the cert used by kube-api which is required for kubectl to trust the certificate when hitting the API with a hostname. When setting this variable, it is required that DNS be updated to route the hostname either to a TCP load balancer or directly to the server node IPs once the VMs are created and acquire IPs. This enables nodes to join the cluster eventually as the bootstrap and subsequent server nodes startup and join. If this variable is not set then nodes will join the cluster using the IP address of the bootstrap control plane node (the first one that starts up) and the API certs will only be valid for the control plane private IPs and the loopback address. It is not recommended to deploy a cluster without setting this to a domain name that you can configure to route to the control plane nodes.

The `bootstrap_cluster` variable being set to true tells the module to deploy one of the server nodes as the bootstrap node. This should be done when deploying a new cluster. If it were set to false, then all of the nodes being deployed would attempt join an existing cluster using the values of `server_dns_name` and `join_token`. This enables easily deploying upgraded RKE2 nodes to migrate workloads to.

After the cluster nodes are deployed, connect to any of the server nodes and wait for cloud-init to finish. Once it is done you can find the default admin kubeconfig file at `/etc/rancher/rke2/rke2.yaml` and kubectl at `/var/lib/rancher/rke2/bin/kubectl`. The server-0 node will be the first node to come up since it is the bootstrap node, so that is usually a good choice to connect to while waiting on the cluster to finish deploying.

# RKE2 Upgrades

This module is designed to enable RKE2 and OS upgrades by deploying a new set of nodes using a new image containing the desired updates and joining them to an existing cluster. Once those nodes join the cluster, you can perform steps to migrate existing workloads from the old nodes to the new nodes and then delete the old nodes. Details of this process can be found in the [RKE2 Upgrade Docs](./rke2-upgrades.md).