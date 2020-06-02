provider "aws" {
  region = "eu-west-1"
}

######
# VPC
######
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2.0"

  name = "demo-vpc"

  cidr = "10.10.0.0/16"

  azs              = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  redshift_subnets = ["10.10.41.0/24", "10.10.42.0/24", "10.10.43.0/24"]
}

###########################
# Security group
###########################
module "sg" {
  source  = "terraform-aws-modules/security-group/aws/modules/redshift"
  version = "~> 3.0"

  name   = "demo-redshift"
  vpc_id = module.vpc.vpc_id

  # Allow ingress rules to be accessed only within current VPC
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]

  # Allow all rules for all protocols
  egress_rules = ["all-all"]
}

###########
# Redshift
###########
module "redshift" {
  source = "../../"

  cluster_identifier      = "my-cluster"
  cluster_node_type       = "dc1.large"
  cluster_number_of_nodes = 1

  cluster_database_name   = "mydb"
  cluster_master_username = "mydbuser"
  cluster_master_password = "MySecretPassw0rd"

  subnets                = module.vpc.redshift_subnets
  vpc_security_group_ids = [module.sg.this_security_group_id]

  //  redshift_subnet_group_name = module.vpc.redshift_subnet_group
}
