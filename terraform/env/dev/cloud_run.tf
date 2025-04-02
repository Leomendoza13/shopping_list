#env/dev/cloud_run.tf

module "cloudrun" {
  source             = "../../modules/cloudrun/"
  cloud_run_name     = "cloudrun-service-${var.environment}"
  image_path         = "${var.region}-docker.pkg.${var.environment}/${var.project_id}/shopping-list-repo-${var.environment}/app:latest"
  db_connection_name = module.storage.sql_instance_connection_name

  #service_account = module.iam.service_account

  #vpc_connector_name = module.vpc.connector_name

  #database connection
  database_url = module.storage.database_connection_string

  database_user     = var.database_user
  database_password = var.database_password

  depends_on = [module.storage]
}