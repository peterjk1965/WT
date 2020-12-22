resource "aws_s3_bucket" "wildthing-app-123" {
  bucket = var.wildthing_app_123
  acl    = "private"
  tags = {
    Name        = "wildthing-app-123"
    Environment = terraform.workspace
  }
}

resource "aws_s3_bucket" "wildthing-app-234" {
  bucket = var.wildthing_app_234
  acl    = "private"
  tags = {
    Name        = "wildthing-app-234"
    Environment = terraform.workspace
  }
}

resource "aws_s3_bucket" "wt-alb-access-logs" {
  bucket = "wt-alb-access-logs"
  policy = "${data.template_file.wildthing.rendered}"
  acl    = "private"
  tags = {
    Name        = "wt-alb-access-logs"
    Environment = "${terraform.workspace}"
  }
}

