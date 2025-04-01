#modules/storage/main.tf

variable sql_database_instance_name {
    type = string
    description = "Name of the SQL database instance"
    default = "main-instance"
}

variable region {
    type = string
    description = "The region of the deployment"
    default = "europe-west1"
}

variable database_name {
    type = string
    description = "The name of the database"
    default = "shopping-database"
}

