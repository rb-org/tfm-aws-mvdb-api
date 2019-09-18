locals {
  api_stage_name  = "${terraform.workspace}"
  api_name        = "${var.prefix}-apigw"
  api_description = "Movie Database API GW"
}
