data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "terraform-state-prod"
    key    = "network/terraform.tfstate"
    region = "us-west-1"
  }
}

variable "alarms_email" {
    default = "arnathan2k@gmail.com"
}
variable "access_key" {
     default = "<PUT IN YOUR AWS ACCESS KEY>"
}
variable "secret_key" {
     default = "<PUT IN YOUR AWS SECRET KEY>"
}
variable "region" {
     default = "us-west-1"
}
variable "availabilityZone" {
     default = "us-west-1b"
}
variable "instanceTenancy" {
    default = "default"
}
variable "dnsSupport" {
    default = true
}
variable "dnsHostNames" {
    default = true
}
variable "vpcCIDRblock" {
    default = "10.0.0.0/16"
}
variable "subnetCIDRblock" {
    default = "10.0.1.0/24"
}
variable "destinationCIDRblock" {
    default = "0.0.0.0/0"
}
variable "ingressCIDRblock" {
    type = list
    default = [ "0.0.0.0/0" ]
}
variable "egressCIDRblock" {
    type = list
    default = [ "0.0.0.0/0" ]
}
variable "mapPublicIP" {
    default = true
}
# end of variables.tf