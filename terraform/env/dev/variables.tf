variable "project_id" {
  type        = string
  description = "The id of the project"
  default     = "recrutement-polyconseil"
}

variable "region" {
  type        = string
  description = "The region of the deployment"
  default     = "europe-west1"
}

variable "environment" {
  type        = string
  description = "Environment (dev, staging, prod)"
  default     = "dev"
}

variable "database_user" {
  description = "User name for database"
  type        = string
}

variable "database_password" {
  description = "Password for database"
  type        = string
}