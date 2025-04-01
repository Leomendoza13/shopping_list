#env/dev/cloud_run.tf

module "cloudrun" {
    source = "../../modules/cloudrun/"
    cloud_run_name = "cloudrun-service-${var.environment}"
    image_path = "${var.region}-docker.pkg.${var.environment}/${var.project_id}/shopping-list-repo-${var.environment}/app:latest"
}