# Copyright 2024 Defense Unicorns
# SPDX-License-Identifier: AGPL-3.0-or-later OR LicenseRef-Defense-Unicorns-Commercial

locals {
  uname = var.unique_suffix ? lower("${var.instance_name}-${random_string.uid.result}") : lower(var.instance_name)
}

resource "random_string" "uid" {
  length  = 3
  special = false
  lower   = true
  upper   = false
  numeric = true
}

data "nutanix_ndb_profile" "software_profile" {
  profile_type = "Software"
  profile_name = var.software_profile_name
}

data "nutanix_ndb_profile" "compute_profile" {
  profile_type = "Compute"
  profile_name = var.compute_profile_name
}

data "nutanix_ndb_profile" "network_profile" {
  profile_type = "Network"
  profile_name = var.network_profile_name
}

data "nutanix_ndb_profile" "db_param_profile" {
  profile_type = "Database_Parameter"
  profile_name = var.db_param_profile_name
}

data "nutanix_ndb_cluster" "cluster" {
  cluster_name = var.nutanix_cluster_name
}

data "nutanix_ndb_sla" "sla" {
  sla_name = var.sla_name
}

resource "nutanix_ndb_database" "postgres-db" {

  // name of database type
  databasetype = "postgres_database"

  // required name of db instance
  name        = local.uname
  description = "Postgres DB provisioned via Terraform"

  // adding the profiles details
  softwareprofileid        = data.nutanix_ndb_profile.software_profile.id
  softwareprofileversionid = data.nutanix_ndb_profile.software_profile.latest_version_id
  computeprofileid         = data.nutanix_ndb_profile.compute_profile.id
  networkprofileid         = data.nutanix_ndb_profile.network_profile.id
  dbparameterprofileid     = data.nutanix_ndb_profile.db_param_profile.id

  clustered = true

  nodecount = var.node_count + 1

  // postgreSQL Info
  postgresql_info {
    listener_port = "5432"

    database_size = var.database_size

    db_password = var.db_password

    database_names = var.database_name

    auth_method = "scram-sha-256"

    post_create_script = "sudo /usr/local/bin/relabel_ndb.sh"

    # cluster_database = true

    ha_instance {
      cluster_name         = "${local.uname}-cluster"
      patroni_cluster_name = "${local.uname}-patroni"
      proxy_read_port      = "5001"
      proxy_write_port     = "5000"
      deploy_haproxy       = var.deploy_haproxy
      # failover_mode = "Automatic"
    }
  }

  // era cluster id
  nxclusterid = data.nutanix_ndb_cluster.cluster.id

  // ssh-key
  sshpublickey = var.ssh_authorized_key

  // node for single instance

  dynamic "nodes" {
    for_each = var.deploy_haproxy ? [1] : []

    content {
      properties {
        name  = "node_type"
        value = "haproxy"
      }
      // name of dbserver vm 
      vmname = "${local.uname}-haproxy-vm"

      // network profile id
      networkprofileid = data.nutanix_ndb_profile.network_profile.id
    }
  }

  nodes {
    properties {
      name  = "role"
      value = "Primary"
    }
    properties {
      name  = "failover_mode"
      value = "Automatic"
    }
    properties {
      name  = "node_type"
      value = "database"
    }

    vmname           = "${local.uname}-vm-0"
    networkprofileid = data.nutanix_ndb_profile.network_profile.id
  }


  dynamic "nodes" {
    for_each = range(var.node_count - 1)

    content {
      properties {
        name  = "role"
        value = "Secondary"
      }
      properties {
        name  = "failover_mode"
        value = "Automatic"
      }
      properties {
        name  = "node_type"
        value = "database"
      }
      // name of dbserver vm 
      vmname = "${local.uname}-vm-${nodes.key + 1}"

      // network profile id
      networkprofileid = data.nutanix_ndb_profile.network_profile.id
    }
  }

  vm_password = var.vm_password

  // time machine info 
  timemachineinfo {
    name        = "${local.uname}-TM"
    description = "Time machine for terraform managed pg database"
    slaid       = data.nutanix_ndb_sla.sla.id

    schedule {
      snapshottimeofday {
        hours   = 1
        minutes = 0
        seconds = 0
      }
      continuousschedule {
        enabled           = true
        logbackupinterval = 30
        snapshotsperday   = 1
      }
      weeklyschedule {
        enabled   = true
        dayofweek = "MONDAY"
      }
      monthlyschedule {
        enabled    = true
        dayofmonth = 1
      }
      quartelyschedule {
        enabled    = true
        startmonth = "JANUARY"
        dayofmonth = 1
      }
      yearlyschedule {
        enabled    = false
        dayofmonth = 1
        month      = "DECEMBER"
      }
    }
  }
}