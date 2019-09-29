variable api_timeout {
  description = "API Gateway integration timeout in milliseconds."
  default     = 29000
}

variable "lambda_invoke_arn" {}
variable "lambda_arn" {}
variable "prefix" {}

variable "default_tags" {
  type = "map"
}
variable "region" {}
variable "lambda_function_name" {}
variable "account_id" {}
