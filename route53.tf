data "aws_route53_zone" "pjktech" {
  name         = "pjktech.com."
  private_zone = false
}

resource "aws_route53_record" "pjktech" {
 zone_id = "${data.aws_route53_zone.pjktech.zone_id}"
 name    = "${data.aws_route53_zone.pjktech.name}"
 type    = "A"
 alias {
   name                   = "${aws_elb.wildthing_elb.dns_name}"
   zone_id                = "${aws_elb.wildthing_elb.zone_id}"
   evaluate_target_health = false
 }
}