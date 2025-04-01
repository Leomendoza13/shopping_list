#env/dev/variables.tf

variable project_id {
    type = string
    description = "The id of the project"
    default = "recrutement-polyconseil"
}

variable region {
    type = string
    description = "The region of the deployment"
    default = "europe-west1"
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  default     = "dev"
}