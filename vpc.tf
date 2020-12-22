resource "aws_vpc" "wildthing" {
  cidr_block       =  var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name        = "WildThingVpc"
    Environment =  terraform.workspace
  }
}
