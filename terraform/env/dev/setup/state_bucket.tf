#env/dev/setup/state_bucket.tf

provider "google" {
  project     = var.project_id
  region      = var.region
}

resource "google_storage_bucket" "bucket-terraform-state" {
  name          = var.bucket_name
  location      = var.location
  force_destroy = true

  uniform_bucket_level_access = true
}