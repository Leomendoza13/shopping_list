#modules/cloudrun/main.tf

resource "google_cloud_run_v2_service" "default" {
  name     = var.cloud_run_name
  location = var.location
  deletion_protection = false
  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    timeout = "300s"
    
    containers {
      image = var.image_path

      ports {
        container_port = 8080
      }
    }
  }
}