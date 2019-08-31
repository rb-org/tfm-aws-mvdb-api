locals {
  prefix      = "${var.prefix}-${terraform.workspace}"
  lambda_name = "${local.prefix}-movies-api"
  env_vars = {
    REGION = var.region
  }
  lambda_filename = "mvdb_lambda"
}
