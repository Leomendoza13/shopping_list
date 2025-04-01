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