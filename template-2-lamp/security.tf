# NAT SG
resource "aws_security_group" "nat-sg" {
  name        = "${var.sg-name-pub}-${lookup(var.environment, terraform.workspace)}-ssh"
  description = "SSH security group for ${lookup(var.environment, terraform.workspace)} environment"
  vpc_id      = "${module.new-vpc.vpc-id}"

  tags = {
    Name     = "${var.sg-name-pub}-${lookup(var.environment, terraform.workspace)}-ssh"
    Template = "${var.template}"
  }
}

resource "aws_security_group_rule" "nat-sg-rule-01" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = "${split(",", var.ips)}"
  security_group_id = "${aws_security_group.nat-sg.id}"
}

resource "aws_security_group_rule" "nat-sg-rule-02" {
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

# ELB SG
resource "aws_security_group" "elb-sg" {
  name        = "elb-${lookup(var.environment, terraform.workspace)}"
  description = "ELB security group for ${lookup(var.environment, terraform.workspace)} environment"
  vpc_id      = "${module.new-vpc.vpc-id}"

  tags = {
    Name     = "${var.sg-name-elb}-${lookup(var.environment, terraform.workspace)}"
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

# Web Server SG
resource "aws_security_group" "web-sg" {
  name        = "${var.sg-name-pri}-${lookup(var.environment, terraform.workspace)}-ssh"
  description = "SSH security group for ${lookup(var.environment, terraform.workspace)} environment"
  vpc_id      = "${module.new-vpc.vpc-id}"

  tags = {
    Name     = "${var.sg-name-pri}-${lookup(var.environment, terraform.workspace)}-ssh"
    Template = "${var.template}"
  }
}

resource "aws_security_group_rule" "web-sg-rule-01" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.nat-sg.id}"
  security_group_id        = "${aws_security_group.web-sg.id}"
}

resource "aws_security_group_rule" "web-sg-rule-02" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.elb-sg.id}"
  security_group_id        = "${aws_security_group.web-sg.id}"
}

resource "aws_security_group_rule" "web-sg-rule-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.web-sg.id}"
}
