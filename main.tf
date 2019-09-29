module "lambda" {
  source = "./lambda"

  prefix       = "${var.prefix}"
  default_tags = "${var.default_tags}"
  region       = "${data.aws_region.current.name}"
  table_arn    = "${data.terraform_remote_state.movies_db.outputs.table_arn}"
  table_name   = "${data.terraform_remote_state.movies_db.outputs.table_name}"
  # api_gw_arn           = "${module.api_gw.api_gw_arn}"
  # api_gw_http_method   = "${module.api_gw.api_gw_http_method}"
  # api_gw_resource_path = "${module.api_gw.api_gw_resource_path}"
  # vpc_id = "${data.terraform_remote_state.movies_base.vpc_id}"
}

module "api_gw" {
  source = "./api_gw"

  lambda_invoke_arn    = "${module.lambda.api_lambda_invoke_arn}"
  lambda_arn           = "${module.lambda.api_lambda_arn}"
  lambda_function_name = "${module.lambda.api_lambda_function_name}"
  prefix               = "${var.prefix}"
  default_tags         = "${var.default_tags}"
  region               = "${data.aws_region.current.name}"
  account_id           = "${data.aws_caller_identity.current.account_id}"
}
