terraform {
  backend "s3" {
    bucket = "radiousterraformbucket"
    key = "remotestate-kube/terraform.tfstate"
    region = "us-west-1"
    dynamodb_table = "terraformstatelock"
  }
}