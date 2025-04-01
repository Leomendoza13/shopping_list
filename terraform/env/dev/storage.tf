#env/dev/storage.tf

module "storage" {
    source = "../../modules/storage/"
    
    sql_database_instance_name = "main-instance-${var.environment}"
    database_name = "shopping-database-${var.environment}"

    repository_id = "shopping-list-repo-${var.environment}"
}