provider "aws" {
  region = "us-east-2"
}

module "reusable_vpc" {
  source      = "../modules/vpc"
  vpc_cidr    = "10.0.0.0/16"
  tenancy     = "default"
  vpc_id      = "module.reusable_vpc.vpc_id"
  subnet_cidr = "10.0.1.0/24"
}

module "reusable_ec2" {
  source = "../modules/ec2"
  ec2_count = "1"
  ami_id = "ami-0f278a714e7f68bd9"
  instance_type = "t2.micro"
  subnet_id = "module.reusable_vpc.subnet_id"
}