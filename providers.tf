provider "aws" {
  region = var.region
}

#next block specifies if terraform.tfstate is save in s3 bucket instead of local laptop
# terraform {
  # backend "s3" {
    # bucket         = "wildthing-tf"
    # key            = "terraform.tfstate"
    # region         = "us-east-2"
    # dynamodb_table = "wildthing-tf"
  # }
# }
