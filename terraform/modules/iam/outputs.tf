#modules/iam/outputs.tf

output "service_account" {
  value = google_service_account.cloud_run_service_account.email
}