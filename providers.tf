

provider "aws" {
  # version             = "~>2.2"
  region              = "${var.region}"
  allowed_account_ids = ["${var.account_id}"]
}
provider "null" {}

provider "archive" {}
