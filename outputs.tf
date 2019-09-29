# output "test" {
#   value = data.terraform_remote_state.movies_db.outputs
# }

# output "table_arn" {
#   value = data.terraform_remote_state.movies_db.outputs.table_name
# }

output "api_lambda_arn" {
  value = "${module.lambda.api_lambda_arn}"
}

output "api_lambda_invoke_arn" {
  value = "${module.lambda.api_lambda_invoke_arn}"
}

output "api_lambda_function_name" {
  value = "${module.lambda.api_lambda_function_name}"
}
