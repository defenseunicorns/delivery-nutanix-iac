# Copyright 2024 Defense Unicorns
# SPDX-License-Identifier: AGPL-3.0-or-later OR LicenseRef-Defense-Unicorns-Commercial

resource "nutanix_ndb_profile" "compute-profile-small" {
  name        = "small-compute"
  description = "compute profile managed by terraform"
  compute_profile {
    core_per_cpu = 1
    cpus         = 2
    memory_size  = 2
  }
  published = true
}

resource "nutanix_ndb_profile" "compute-profile-medium" {
  name        = "medium-compute"
  description = "compute profile managed by terraform"
  compute_profile {
    core_per_cpu = 1
    cpus         = 2
    memory_size  = 4
  }
  published = true
}

resource "nutanix_ndb_profile" "compute-profile-large" {
  name        = "large-compute"
  description = "compute profile managed by terraform"
  compute_profile {
    core_per_cpu = 1
    cpus         = 2
    memory_size  = 8
  }
  published = true
}

resource "nutanix_ndb_profile" "compute-profile-xlarge" {
  name        = "xlarge-compute"
  description = "compute profile managed by terraform"
  compute_profile {
    core_per_cpu = 1
    cpus         = 4
    memory_size  = 16
  }
  published = true
}

resource "nutanix_ndb_profile" "compute-profile-2xlarge" {
  name        = "2xlarge-compute"
  description = "compute profile managed by terraform"
  compute_profile {
    core_per_cpu = 1
    cpus         = 8
    memory_size  = 32
  }
  published = true
}

resource "nutanix_ndb_profile" "compute-profile-4xlarge" {
  name        = "4xlarge-compute"
  description = "compute profile managed by terraform"
  compute_profile {
    core_per_cpu = 1
    cpus         = 16
    memory_size  = 64
  }
  published = true
}
