terraform {
  backend "s3" {
    bucket = "radiousterraformbucket"
    key = "remotestatetest1/terraform.tfstate"
    region = "us-west-1"
    dynamodb_table = "terraformstatelock"
  }
}