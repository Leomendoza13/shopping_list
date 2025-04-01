#env/dev/storage.tf

module "sql_database_instance" {
    source = "../../modules/storage/"
    
    sql_database_instance_name = "main-instance-${var.environment}"
    database_name = "shopping-database-${var.environment}"

}