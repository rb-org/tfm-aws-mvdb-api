resource "aws_lambda_permission" "invoke" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "${var.lambda_function_name}"
  principal     = "apigateway.amazonaws.com"
  # source_arn    = "${var.api_gw_arn}/*/*/*"
  source_arn = "${aws_api_gateway_rest_api.api.execution_arn}/*/*${aws_api_gateway_resource.get.path}"
  # source_arn = "arn:aws:execute-api:${var.region}:${var.account_id}:${aws_api_gateway_rest_api.api.id}/*/${aws_api_gateway_method.get.http_method}${aws_api_gateway_resource.get.path}"

}

