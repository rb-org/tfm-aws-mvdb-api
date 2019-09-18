provider "aws" {
  version             = "~>2.28"
  region              = "${var.region}"
  allowed_account_ids = ["${var.account_id}"]
}
provider "null" {
  version = "~> 2.1"
}

provider "archive" {
  version = "~> 1.2"
}
