#modules/storage/main.tf

resource "google_sql_database_instance" "sql_database_instance" {
  name             = var.sql_database_instance_name
  database_version = "POSTGRES_15"
  region           = var.region

  settings {
    # Second-generation instance tiers are based on the machine
    # type. See argument reference below.
    tier = "db-f1-micro"
    /*
    ip_configuration {
      ipv4_enabled    = false 
      private_network = var.private_network  
    }*/
  }
  deletion_protection = false
}

resource "google_sql_database" "database" {
  name     = var.database_name
  instance = google_sql_database_instance.sql_database_instance.name
  
}

resource "google_artifact_registry_repository" "shopping_list_repo" {
  location      = var.region
  repository_id = var.repository_id
  format        = "DOCKER"
  description   = "Docker repository for shopping list application"
}

