#modules/network/main.tf

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

resource "google_compute_network" "vpc_network" {
  name                    = var.name
  auto_create_subnetworks = false
  description             = "VPC Network pour l'application de liste de courses"
}

resource "google_compute_subnetwork" "subnet" {
  name                     = "${var.name}-subnet"
  ip_cidr_range            = "10.0.0.0/24"
  region                   = var.region
  network                  = google_compute_network.vpc_network.id
  private_ip_google_access = true
}

resource "google_vpc_access_connector" "connector" {
  name          = "${var.name}-connector"
  region        = var.region
  ip_cidr_range = "10.8.0.0/28"
  network       = google_compute_network.vpc_network.name

  max_throughput = 200
}