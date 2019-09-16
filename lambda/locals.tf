locals {
  prefix      = "${var.prefix}-${terraform.workspace}"
  lambda_name = "${local.prefix}-movies-api"
  env_vars = {
    REGION     = "${var.region}"
    TABLE_NAME = "${var.table_name}"
  }
  lambda_filename = "mvdb_lambda"
}
