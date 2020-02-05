output "elb-arn" {
  # value = "${aws_lb.elb.*.arn}"
  value = "${aws_lb.elb.arn}"
}