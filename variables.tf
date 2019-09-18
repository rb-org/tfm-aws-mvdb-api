variable "prefix" {
  default = "mvdb"
}

variable "region" {
  default = "eu-west-1"
}
# Tags
variable "default_tags" {
  type = "map"
  default = {
    Github-Repo = "rb-org/tfm-aws-mvdb-api"
    Terraform   = "true"
    Creator     = "rupert"
  }
}
# Account IDs
variable "account_id" {
}

# Remote State S3 Bucket
variable "remote_state_s3_auto" {
  description = "S3 bucket name holding the Terraform remote state file"
  default     = "tfm-remote-state-240442524813"
}


