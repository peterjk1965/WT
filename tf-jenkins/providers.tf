provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "wildthing-tf"
    key    = "terraform.state"
    region = "us-east-2"
  }
}