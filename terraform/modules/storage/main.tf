#modules/storage/main.tf

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
}

resource "google_sql_database_instance" "sql_database_instance" {
  name             = var.sql_database_instance_name
  database_version = "POSTGRES_15"
  region           = var.region

  settings {
    tier = "db-f1-micro"


    ip_configuration {
      ipv4_enabled = true
      authorized_networks {
        name  = "cloud-run"
        value = "0.0.0.0/0"
      }
    }

    backup_configuration {
      enabled    = true
      start_time = "02:00"
    }

    database_flags {
      name  = "log_connections"
      value = "on"
    }

    database_flags {
      name  = "log_disconnections"
      value = "on"
    }

    database_flags {
      name  = "log_lock_waits"
      value = "on"
    }

    database_flags {
      name  = "log_checkpoints"
      value = "on"
    }

    database_flags {
      name  = "log_temp_files"
      value = "0"
    }
  }
  deletion_protection = false
}

resource "google_sql_user" "database_user" {
  name     = var.database_user
  instance = google_sql_database_instance.sql_database_instance.name
  password_wo = var.database_password
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