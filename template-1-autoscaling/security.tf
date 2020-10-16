### NACLS ###

module "nacls_vpc" {
  source = "../modules/security/nacls/nacl"
  vpc-id = "${module.new-vpc.vpc-id}"
  # subnet-ids = "${module.pri_subnet_1.subnet-id}" # this can get very complicated
  #Tags
  environment = "${terraform.workspace}"
  application = "${var.application}"
  purpose     = "${var.purpose}"
  name        = "nacls"
  created-on  = "${var.created-on}"
  template    = "${var.template}"
}

module "nacls_deny_rules_egress" {
  source     = "../modules/security/nacls/rules"
  nacls-id   = "${module.nacls_vpc.id}"
  egress     = "${split(",", var.egress)}"
  protocol   = "${var.protocol}"
  cidr-block = "${split(",", var.cidr)}"
  rule-no    = "${split(",", var.rule-no)}"
  action     = "${split(",", var.action)}"
  from-port  = "${var.from-port}"
  to-port    = "${var.to-port}"
}

module "nacls_deny_rules_ingress" {
  source     = "../modules/security/nacls/rules"
  nacls-id   = "${module.nacls_vpc.id}"
  egress     = "${split(",", var.ingress)}"
  protocol   = "${var.protocol}"
  cidr-block = "${split(",", var.cidr)}"
  rule-no    = "${split(",", var.rule-no)}"
  action     = "${split(",", var.action)}"
  from-port  = "${var.from-port}"
  to-port    = "${var.to-port}"
}

### SECURITY GROUPS ###

## Nat ##

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
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["172.168.0.64/27", "172.168.0.96/27","172.168.0.160/27","172.168.0.192/27"]
  security_group_id = "${aws_security_group.nat-sg.id}"
}

resource "aws_security_group_rule" "nat-sg-rule-03" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["172.168.0.64/27", "172.168.0.96/27","172.168.0.160/27","172.168.0.192/27"]
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

## Elb ##

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

## Web ##

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
