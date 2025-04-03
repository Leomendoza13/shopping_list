variable "name" {
  type        = string
  description = "Name of the vpc"
  default     = "vpc"
}

variable "region" {
  type        = string
  description = "The region of the deployment"
  default     = "europe-west1"
}
