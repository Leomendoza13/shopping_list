#modules/iam/main.tf

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}
resource "google_service_account" "cloud_run_service_account" {
  account_id   = "cloud-run-service-account"
  display_name = "Service Account for Cloud Run"
  description  = "Compte de service utilisé par Cloud Run pour accéder à Cloud SQL"
}

resource "google_project_iam_member" "cloud_run_sql_client" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.cloud_run_service_account.email}"
}

resource "google_project_iam_member" "cloud_run_sql_instance_user" {
  project = var.project_id
  role    = "roles/cloudsql.instanceUser"
  member  = "serviceAccount:${google_service_account.cloud_run_service_account.email}"
}

resource "google_service_account_iam_binding" "cloud_run_service_account_user" {
  service_account_id = google_service_account.cloud_run_service_account.name
  role               = "roles/iam.serviceAccountUser"
  members = [
    "serviceAccount:${var.project_number}@cloudservices.gserviceaccount.com"
  ]
}