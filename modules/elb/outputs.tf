output "elb-arn" {
  # value = "${aws_lb.elb.*.arn}"
  value = "${aws_lb.elb.arn}"
}

# would it be possible to get the ip address from the load balancer
output "elb-dns-name" {
  value = "${aws_lb.elb.dns_name}"
}

output "elb-zone-id" {
  value = "${aws_lb.elb.zone_id}"
}
