#env/dev/backend.tf

terraform {
  backend "gcs" {
    bucket = "shopping-list-terraform-state-dev"
    prefix = "terraform/state"
  }
}