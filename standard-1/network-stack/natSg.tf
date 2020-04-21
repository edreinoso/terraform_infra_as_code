# SSH SG
resource "aws_security_group" "nat-sg" {
  name        = "${var.sg-name-pub}-${lookup(var.environment, terraform.workspace)}-ssh"
  description = "SSH security group for ${lookup(var.environment, terraform.workspace)} environment"
  vpc_id      = "${module.new-vpc.vpc-id}"

  tags = {
    Name     = "${var.sg-name-pub}-${lookup(var.environment, terraform.workspace)}-ssh"
    Template = "${var.template}"
  }
}

#would this rule be really needed?
resource "aws_security_group_rule" "nat-sg-rule-01" {
  # count     = "${length(var.cidr-blocks)}"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = "${split(",", var.ips)}"
  security_group_id = "${aws_security_group.nat-sg.id}"
}

resource "aws_security_group_rule" "nat-sg-rule-02" {
  # count     = "${length(var.cidr-blocks)}"
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.nat-sg.id}"
}

resource "aws_security_group_rule" "nat-sg-rule-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.nat-sg.id}"
}
