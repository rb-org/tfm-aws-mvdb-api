module "lambda" {
  source = "./lambda"

  prefix       = var.prefix
  default_tags = var.default_tags
  region       = data.aws_region.current.name
  table_arn    = data.terraform_remote_state.movies_db.outputs.table_arn
}
