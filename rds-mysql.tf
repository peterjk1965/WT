resource "aws_db_instance" "wildthing" {
  identifier           = "wildthing-${terraform.workspace}"  
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "wildthing"
  username             = "wildthing"
  #bad idea to store password here. Pass myst be 8 chars
  password             = "Asheville08!"
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name       = "${aws_db_subnet_group.wildthing.id}"
  backup_window        =  "01:00-01:30"
  auto_minor_version_upgrade = false
  skip_final_snapshot = true
  final_snapshot_identifier = "wildthing-final-snap"
}

resource "aws_db_subnet_group" "wildthing" {
  name       = "wildthing-rds"
  subnet_ids = "${aws_subnet.private.*.id}"

  tags = {
    Name = "Wildthing RDS Subnet Group"
  }
}

resource "aws_security_group" "rds_sg" {
 name        = "rds_sg"
 description = "Allow traffic for rds"
 vpc_id      = aws_vpc.wildthing.id
   
 ingress {
 from_port   = 3306
 to_port     = 3306
 protocol    = "tcp"
 security_groups = ["${aws_security_group.web_sg.id}"]
 }
 egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
   }
 }