module "vpc" {
  source = "../../modules/network/"
  name   = "vpc-${var.environment}"
}