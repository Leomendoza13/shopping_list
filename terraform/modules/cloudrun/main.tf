#modules/cloudrun/main.tf

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
}

resource "google_cloud_run_v2_service" "default" {
  name                = var.cloud_run_name
  location            = var.location
  deletion_protection = false
  ingress             = "INGRESS_TRAFFIC_ALL"

  template {

    #service_account = var.service_account 
    /*
    annotations = {
      "run.googleapis.com/vpc-access-connector" = var.vpc_connector_name
      "run.googleapis.com/vpc-access-egress"    = "all-traffic"
    }*/


    containers {
      image = var.image_path

      ports {
        container_port = 8080
      }

      env {
        name  = "DATABASE_URL"
        value = var.database_url
      }

      env {
        name  = "DB_USER"
        value = var.database_user
      }

      env {
        name  = "DB_PASSWORD"
        value = var.database_password
      }

      env {
        name  = "DB_CONNECTION_NAME"
        value = var.db_connection_name
      }

      volume_mounts {
        name       = "cloudsql"
        mount_path = "/cloudsql"
      }
    }

    volumes {
      name = "cloudsql"
      cloud_sql_instance {
        instances = [var.db_connection_name]
      }
    }
  }
}