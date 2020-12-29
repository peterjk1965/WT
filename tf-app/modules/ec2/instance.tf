resource "aws_instance" "web" {
  count         = "var.ec2_count"
  ami           = "var.ami_id"
  instance_type = "var.instance_type"
  id            = "var.subnet.id"

  tags = {
    Name = "HelloWorld"
  }
}