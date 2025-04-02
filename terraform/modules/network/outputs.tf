#modules/network/outputs.tf

output "vpc_id" {
  value = google_compute_network.vpc_network.id
}

output "vpc_name" {
  value = google_compute_network.vpc_network.name
}

output "subnet_id" {
  value = google_compute_subnetwork.subnet.id
}

output "connector_id" {
  value = google_vpc_access_connector.connector.id
}

output "connector_name" {
  value = google_vpc_access_connector.connector.name
}