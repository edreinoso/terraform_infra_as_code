output "public-sg-id" {
  value = "${aws_security_group.nat-sg.id}"
}


output "private-sg-id" {
  value = "${aws_security_group.internal-sg.id}"
}

output "elb-sg-id" {
  value = "${aws_security_group.elb-sg.id}"
}