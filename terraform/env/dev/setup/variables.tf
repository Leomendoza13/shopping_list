#env/dev/setup/variables.tf
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


variable location {
    type = string
    description = "Location of the infra"
    default = "EU"
}

variable bucket_name {
    type = string
    description = "The name of the terraform state bucket"
    default = "shopping-list-terraform-state-dev"
}