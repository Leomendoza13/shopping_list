#modules/storage/main.tf

variable "sql_database_instance_name" {
  type        = string
  description = "Name of the SQL database instance"
  default     = "main-instance"
}

variable "region" {
  type        = string
  description = "The region of the deployment"
  default     = "europe-west1"
}

variable "database_name" {
  type        = string
  description = "The name of the database"
  default     = "shopping-database"
}

variable "repository_id" {
  type        = string
  description = "The id of the registry"
  default     = "shopping-list-repo"
}

variable "database_user" {
  description = "User name for database"
  type        = string
}

variable "database_password" {
  description = "Password for database"
  type        = string
}
/*
variable cloud_run_ip_address {
    description = "Ip address of cloud run"
    type = string
}

variable "private_network" {
  description = "VPC ID for private connexions"
  type        = string
}
*/