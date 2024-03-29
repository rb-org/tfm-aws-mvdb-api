resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
    "aws_api_gateway_integration.get",
    "aws_api_gateway_integration.proxy_any",
    "aws_api_gateway_method.get",
    "aws_api_gateway_method.proxy_any",

  ]
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  # stage_name  = "${local.api_stage_name}"
  stage_name = ""
}


resource "aws_api_gateway_integration" "get" {
  content_handling        = "CONVERT_TO_TEXT"
  rest_api_id             = "${aws_api_gateway_rest_api.api.id}"
  resource_id             = "${aws_api_gateway_resource.get.id}"
  http_method             = "${aws_api_gateway_method.get.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${var.lambda_invoke_arn}"
}

resource "aws_api_gateway_integration" "proxy_any" {
  content_handling        = "CONVERT_TO_TEXT"
  http_method             = "${aws_api_gateway_method.proxy_any.http_method}"
  integration_http_method = "POST"
  resource_id             = "${aws_api_gateway_resource.proxy.id}"
  rest_api_id             = "${aws_api_gateway_rest_api.api.id}"
  timeout_milliseconds    = "${var.api_timeout}"
  type                    = "AWS_PROXY"
  uri                     = "${var.lambda_invoke_arn}"
}

resource "aws_api_gateway_method" "get" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = "${aws_api_gateway_resource.get.id}"
  rest_api_id   = "${aws_api_gateway_rest_api.api.id}"
  request_models = {
    "application/json" = "Error"
  }

}

resource "aws_api_gateway_resource" "get" {
  path_part = "movies"
  # path_part   = "resource"
  parent_id   = "${aws_api_gateway_rest_api.api.root_resource_id}"
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
}

resource "aws_api_gateway_method" "proxy_any" {
  authorization = "NONE"
  http_method   = "ANY"
  resource_id   = "${aws_api_gateway_resource.proxy.id}"
  rest_api_id   = "${aws_api_gateway_rest_api.api.id}"
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  parent_id   = "${aws_api_gateway_rest_api.api.root_resource_id}"
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_rest_api" "api" {
  description = "${local.api_description}"
  name        = "${local.api_name}"
}


resource "aws_api_gateway_method_response" "response_200_any" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  resource_id = "${aws_api_gateway_resource.proxy.id}"
  http_method = "${aws_api_gateway_method.proxy_any.http_method}"
  status_code = "200"
}

resource "aws_api_gateway_method_response" "response_200_get" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  resource_id = "${aws_api_gateway_resource.get.id}"
  http_method = "${aws_api_gateway_method.get.http_method}"
  status_code = "200"
}

resource "aws_api_gateway_method_settings" "get" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  stage_name  = "${aws_api_gateway_stage.main.stage_name}"
  # stage_name  = "${local.api_stage_name}"
  method_path = "${aws_api_gateway_resource.get.path_part}/${aws_api_gateway_method.get.http_method}"

  settings {
    metrics_enabled = false
    logging_level   = "INFO"
  }
  depends_on = ["aws_api_gateway_deployment.deployment"]
}

resource "aws_api_gateway_stage" "main" {
  stage_name    = "${local.api_stage_name}"
  rest_api_id   = "${aws_api_gateway_rest_api.api.id}"
  deployment_id = "${aws_api_gateway_deployment.deployment.id}"
}
