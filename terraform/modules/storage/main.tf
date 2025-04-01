#modules/storage/main.tf

resource "google_sql_database_instance" "sql_database_instance" {
  name             = var.sql_database_instance_name
  database_version = "POSTGRES_15"
  region           = var.region

  settings {
    # Second-generation instance tiers are based on the machine
    # type. See argument reference below.
    tier = "db-f1-micro"
  }

  deletion_protection = false
}

resource "google_sql_database" "database" {
  name     = var.database_name
  instance = google_sql_database_instance.sql_database_instance.name
}
