resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow traffic for web apps"
  vpc_id      = aws_vpc.wildthing.id
    
  ingress {
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  #cidr_blocks = ["24.14.91.178/32"]
  cidr_blocks = ["0.0.0.0/0"]
}  
  ingress {
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  #cidr_blocks = ["24.14.91.178/32"]
  cidr_blocks = ["0.0.0.0/0"]
}
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
