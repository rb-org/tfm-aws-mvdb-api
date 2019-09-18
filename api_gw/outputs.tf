output "api_gw_arn" {
  value = "${aws_api_gateway_rest_api.api.execution_arn}"
}

output "api_gw_http_method" {
  value = "${aws_api_gateway_method.get.http_method}"
}
output "api_gw_resource_path" {
  value = "${aws_api_gateway_resource.proxy.path}"
}

