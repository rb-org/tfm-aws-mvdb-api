output "api_lambda_arn" {
  value = "${aws_lambda_function.main.arn}"
}

output "api_lambda_invoke_arn" {
  value = "${aws_lambda_function.main.invoke_arn}"
}
