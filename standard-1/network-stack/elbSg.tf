# ELB SG
resource "aws_security_group" "elb-sg" {
  name        = "elb-${lookup(var.environment, terraform.workspace)}"
  description = "HTTP security group for ${lookup(var.environment, terraform.workspace)} environment"
  vpc_id      = "${module.new-vpc.vpc-id}"

  tags = {
    Name     = "elb-${lookup(var.environment, terraform.workspace)}"
    Template = "${var.template}"
  }
}

resource "aws_security_group_rule" "elb-sg-rule" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.elb-sg.id}"
}

resource "aws_security_group_rule" "elb-sg-rule-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.elb-sg.id}"
}
