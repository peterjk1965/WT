resource "aws_launch_configuration" "web_lc" {
  name                 = "web_lc"
  image_id             = "${var.web_amis[var.region]}"
  instance_type        = "t2.micro"
  key_name             = "${aws_key_pair.web.key_name}"
  user_data            = "${file("scripts/apache.sh")}"
  iam_instance_profile = "${aws_iam_instance_profile.s3_ec2_profile.name}"
  security_groups      = ["${aws_security_group.web_sg.id}"]
}

resource "aws_autoscaling_group" "wildthing_asg" {
  name     = "wildthing_asg"
  min_size = 2
  max_size = 2

  health_check_grace_period = 60
  health_check_type         = "ELB"
  load_balancers            = ["${aws_elb.wildthing_elb.name}"]
  vpc_zone_identifier       = "${local.pub_sub_ids}"
  launch_configuration      = "${aws_launch_configuration.web_lc.name}"
}

resource "aws_autoscaling_policy" "AddInstancesPolicy" {
  name                   = "AddInstancesPolicy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = "${aws_autoscaling_group.wildthing_asg.name}"
}

resource "aws_autoscaling_policy" "RemoveInstancesPolicy" {
  name                   = "RemoveInstancesPolicy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = "${aws_autoscaling_group.wildthing_asg.name}"
}


resource "aws_cloudwatch_metric_alarm" "avg_cpu_ge_80" {
  alarm_name          = "avg_cpu_ge_80"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.wildthing_asg.name}"
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = ["${aws_autoscaling_policy.AddInstancesPolicy.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "avg_cpu_le_30" {
  alarm_name          = "avg_cpu_le_30"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.wildthing_asg.name}"
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = ["${aws_autoscaling_policy.RemoveInstancesPolicy.arn}"]
}
