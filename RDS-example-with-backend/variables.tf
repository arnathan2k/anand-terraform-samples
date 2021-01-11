variable "subnet_count" {
  default = 2
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

variable "natsupport"{
  default = true
}
variable "vpcCIDRblock" {
    default = "10.0.0.0/16"
}
variable "publicsubnetCIDRblock1" {
    default = "10.0.1.0/24"
}

variable "publicSubnetCIDRblock2" {
  default = "10.0.3.0/24"
}

variable "privateSubnetCIDRblock1"{
  default = "10.0.2.0/24"
}

variable "privateSubnetCIDRblock2" {
  default = "10.0.4.0/24"
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