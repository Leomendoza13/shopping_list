#env/dev/storage.tf

module "storage" {
  source = "../../modules/storage/"

  sql_database_instance_name = "main-instance-${var.environment}"
  database_name              = "shopping-database-${var.environment}"

  repository_id = "shopping-list-repo-${var.environment}"


  #database connection
  database_user     = var.database_user
  database_password = var.database_password


  #private_network = module.vpc.vpc_id

  #depends_on = [module.vpc]
}