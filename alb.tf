resource "aws_lb_target_group" "wildthing" {
  name     = "wildthing-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.wildthing.id}"
}

resource "aws_lb_target_group_attachment" "wildthing" {
  count            = "${var.web_ec2_count}"
  target_group_arn = "${aws_lb_target_group.wildthing.arn}"
  target_id        = "${aws_instance.web.*.id[count.index]}"
  port             = 80
}

resource "aws_lb" "wildthing" {
  name               = "wildthing-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.elb_sg.id}"]
  subnets            = "${local.pub_sub_ids}"

  access_logs {
    bucket  = "wt-alb-access-logs"
    enabled = true
  }
  tags = {
    Environment = "${terraform.workspace}"
  }
}


resource "aws_lb_listener" "web_tg" {
  load_balancer_arn = "${aws_lb.wildthing.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.wildthing.arn}"
  }
}

data "template_file" "wildthing" {
  template = "${file("scripts/iam/alb-s3-access-logs.json")}"
  vars = {
    access_logs_bucket = "wt_alb_access_logs"
  }
}
