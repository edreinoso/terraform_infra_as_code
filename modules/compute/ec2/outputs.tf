output "ec2-id" {
  value = "${aws_instance.ec2.id}"
  # value = "${aws_instance.ec2.*.id}"
}

output "public-dns" {
  value = "${aws_instance.ec2.public_dns}"
}


# "arn:aws:ec2:us-east-1:130193131803:instance/${module.ec2-no-ebs.ec2-id}"
# "arn:aws:ec2:us-east-1:130193131803:instance/${element(element(module.ec2-no-ebs.ec2-id, 0), 0)}"
# "arn:aws:ec2:us-east-1:130193131803:instance/${module.ec2-with-ebs.ec2-id}"