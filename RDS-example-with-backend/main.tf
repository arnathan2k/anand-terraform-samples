##############################################################################
#  DATA
##############################################################################
data "aws_availability_zones" "available" {  
}
##############################################################################
#  RESOURCES
##############################################################################

resource "aws_vpc" "RDS_Demo_uswest1_vpc"{
    provider = aws.California
    cidr_block = var.vpcCIDRblock
    instance_tenancy = var.instanceTenancy
    enable_dns_hostnames = var.dnsHostNames
    enable_dns_support = var.dnsSupport
    #enable_nat_gateway = var.natsupport

    
}

resource "aws_subnet" "public_subnet1"{
    vpc_id = aws_vpc.RDS_Demo_uswest1_vpc.id
    cidr_block = var.publicsubnetCIDRblock1
}
resource "aws_subnet" "public_subnet2"{
    vpc_id = aws_vpc.RDS_Demo_uswest1_vpc.id
    cidr_block = var.publicSubnetCIDRblock2
}

##############################################################################
#  RDS Module
##############################################################################
module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 2.0"

  identifier = "demodb"

  engine            = "mysql"
  engine_version    = "5.7.19"
  instance_class    = "db.t2.small"
  allocated_storage = 5

  name     = "demodb"
  username = "user"
  password = "YourPwdShouldBeLongAndSecure!"
  port     = "3306"

  iam_database_authentication_enabled = true

  vpc_security_group_ids = ["sg-0d368fb7310fa6d61"]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
  monitoring_interval = "30"
  monitoring_role_name = "MyRDSMonitoringRole"
  create_monitoring_role = true

  tags = {
    Owner       = "user"
    Environment = "dev"
  }

  # DB subnet group
  subnet_ids = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]

  # DB parameter group
  family = "mysql5.7"

  # DB option group
  major_engine_version = "5.7"

  # Snapshot name upon DB deletion
  final_snapshot_identifier = "demodb"

  # Database Deletion Protection
  deletion_protection = true

  parameters = [
    {
      name = "character_set_client"
      value = "utf8"
    },
    {
      name = "character_set_server"
      value = "utf8"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
}
/*
 resource "aws_subnet" "private_subnet1" {
    vpc_id = aws_vpc.RDS_Demo_uswest1_vpc.id    
    cidr_block = var.privateSubnetCIDRblock1
}

resource "aws_subnet" "private_subnet2" {

    cidr_block = var.privateSubnetCIDRblock2
}

*/