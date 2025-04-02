#modules/cloudrun/variables.tf

variable project_id {
    type = string
    description = "The id of the project"
    default = "recrutement-polyconseil"
}

variable location {
    type = string
    description = "The location of the deployment"
    default = "europe-west1"
}

variable cloud_run_name {
    type = string
    description = "The name of the cloud run"
    default = "cloudrun-service"
}

variable image_path {
    type = string
    description = "The path of the image docker inside the registry"
    default = "europe-west1-docker.pkg/recrutement-polyconseil/shopping-list-repo/app:latest"
}

variable db_connection_name {
  description = "Connection name for the Cloud SQL instance"
  type        = string
}
/*
variable "service_account" {
  description = "The service account email to use for the Cloud Run service"
  type        = string
}

variable vpc_connector_name {
    type = string
    description = "vpc_connector_name"
}*/

variable "database_user" {
  description = "User name for database"
  type        = string
}

variable "database_password" {
  description = "Password for database"
  type        = string
}

variable "database_url" {
  description = "Url for database"
  type        = string
}