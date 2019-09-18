module "lambda" {
  source = "./lambda"

  prefix               = "${var.prefix}"
  default_tags         = "${var.default_tags}"
  region               = "${data.aws_region.current.name}"
  table_arn            = "${data.terraform_remote_state.movies_db.outputs.table_arn}"
  table_name           = "${data.terraform_remote_state.movies_db.outputs.table_name}"
  api_gw_arn           = "${module.api_gw.api_gw_arn}"
  api_gw_http_method   = "${module.api_gw.api_gw_http_method}"
  api_gw_resource_path = "${module.api_gw.api_gw_resource_path}"
}

module "api_gw" {
  source = "./api_gw"

  lambda_invoke_arn = "${module.lambda.api_lambda_invoke_arn}"
  prefix            = "${var.prefix}"
  default_tags      = "${var.default_tags}"
  region            = "${data.aws_region.current.name}"
}
