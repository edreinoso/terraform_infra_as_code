### NAT ###

resource "aws_security_group" "nat-sg" {
  name        = "${var.sg-name-pub}-${terraform.workspace}-public"
  description = "public security group for ${terraform.workspace} environment"
  vpc_id      = "${module.new-vpc.vpc-id}"

  tags = {
    Name          = "${var.sg-name-pub}-${terraform.workspace}-public"
    Template      = "${var.template}"
    Environment   = "${terraform.workspace}"
    Application   = "${var.application}"
    Purpose       = "${var.purpose}"
    Creation_Date = "${var.created-on}"
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

### ELB ###

resource "aws_security_group" "elb-sg" {
  name        = "elb-${terraform.workspace}"
  description = "elb security group for ${terraform.workspace} environment"
  vpc_id      = "${module.new-vpc.vpc-id}"

  tags = {
    Name          = "${var.sg-name-elb}-${terraform.workspace}"
    Template      = "${var.template}"
    Environment   = "${terraform.workspace}"
    Application   = "${var.application}"
    Purpose       = "${var.purpose}"
    Creation_Date = "${var.created-on}"
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

### WEB ###

resource "aws_security_group" "web-sg" {
  name        = "${var.sg-name-pri}-${terraform.workspace}-web"
  description = "web security group for ${terraform.workspace} environment"
  vpc_id      = "${module.new-vpc.vpc-id}"

  tags = {
    Name          = "${var.sg-name-pri}-${terraform.workspace}-web"
    Template      = "${var.template}"
    Environment   = "${terraform.workspace}"
    Application   = "${var.application}"
    Purpose       = "${var.purpose}"
    Creation_Date = "${var.created-on}"
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
