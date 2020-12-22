variable "vpc_cidr" {
  description = "Choose cidr for vpc"
  type        =  string
  default     = "10.20.0.0/16"
}

variable "region" {
  description = "Choose region for your stack"
  type        =  string
  default     = "us-east-2"
}

variable "nat_amis" {
  type = "map"
  default = {
    us-east-1 = "ami-00a9d4a05375b2763"
    us-east-2 = "ami-00d1f8201864cc10c"
  }
}

variable "web_instance_type" {
  description = "Choose instance type for your stack"
  type        =  string
  default     = "t2.micro"
}

variable "web_tags" {
  type = "map"
  default = {
     Name = "Webserver"  
  }
}

variable "web_amis" {
  type = "map"
  default = {
    us-east-1 = "ami-0b898040803850657"
    us-east-2 = "ami-0d8f6eb4f641ef691"
  }
}

variable "web_ec2_count" {
  description = "Choose number ec2 instances for web"
  type        = "string"
  default     = "0"
}

variable "wildthing_app_123" {
  default = "wildthing-app-123"
}

variable "wildthing_app_234" {
  default = "wildthing-app-234"
}
