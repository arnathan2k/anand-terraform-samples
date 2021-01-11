
variable "aws_remotestate_bucket" {
  default = "radiousterraformbucket"
}

variable "aws_dynamodb_table" {
  default = "terraformstatelock"
}



provider "aws" {
  region = "us-west-1"
}



resource "aws_dynamodb_table" "terraform_statelock" {
  name = var.aws_dynamodb_table
  read_capacity = 5
  write_capacity = 5
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = var.aws_remotestate_bucket
  acl = "private"
  force_destroy = true

  versioning {
    enabled = true
  }

}
