resource "nutanix_ndb_profile" "tuned_postgres_profile" {
  name        = "tuned_postgres_profile"
  description = "Postgres profile with settings tuned slightly from NDB default profile. This is limited to settings exposed by NDB. Additional tuning may need done after the DB has been created."
  engine_type = "postgres_database"
  database_parameter_profile {
    postgres_database {
      max_connections              = "200"
      random_page_cost             = "1.1"
      min_wal_size                 = "1GB"
      max_wal_size                 = "4GB"
      effective_io_concurrency     = "200"
      checkpoint_completion_target = "0.9"
    }
  }
  published = true
}
