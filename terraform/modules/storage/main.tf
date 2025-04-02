resource "google_sql_database_instance" "sql_database_instance" {
  name             = var.sql_database_instance_name
  database_version = "POSTGRES_15"
  region           = var.region

  settings {
    tier = "db-f1-micro"

    # ip_configuration {
    #   ipv4_enabled    = false 
    #   private_network = var.private_network  
    # }

    #only dev
    ip_configuration {
      authorized_networks {
        name  = "cloud-run"
        value = "0.0.0.0/0"
      }
    }
  }
  deletion_protection = false
}

resource "google_sql_user" "database_user" {
  name     = var.database_user
  instance = google_sql_database_instance.sql_database_instance.name
  password = var.database_password
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