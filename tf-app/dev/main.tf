provider "aws" {
  region = "us-east-2"
}

module "my_vpc" {
  source      = "../modules/vpc"
  vpc_cidr    = "10.2.0.0/16"
  tenancy     = "default"
  vpc_id      = "${module.my_vpc.vpc_id}"
  subnet_cidr = "10.2.1.0/24"
}

module "my_ec2" {
  source = "../modules/ec2"
  ec2_count = "1"
  ami_id = "ami-0323b157afd11740f"
  instance_type = "t3.micro"
  subnet_id = "${module.my_vpc.subnet_id}"
}