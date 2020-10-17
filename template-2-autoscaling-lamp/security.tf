### SECURITY GROUPS ###
  
  ## NAT SG ##
    
    resource "aws_security_group" "nat-sg" {
      name        = "${var.sg-name-pub}-${terraform.workspace}-${lookup(var.protocol, nat)}"
      description = "NAT security group for ${var.template} in ${terraform.workspace} environment"
      vpc_id      = "${module.new-vpc.vpc-id}"

      tags = {
        Name          = "${var.sg-name-pub}-${terraform.workspace}-${lookup(var.protocol, nat)}"
        Template      = "${var.template}"
        Environment   = "${terraform.workpsace}"
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
      cidr_blocks       = ["",""] # web and app subnets
      security_group_id = "${aws_security_group.nat-sg.id}"
    }

    resource "aws_security_group_rule" "nat-sg-rule-03" {
      type              = "ingress"
      from_port         = 443
      to_port           = 443
      protocol          = "tcp"
      cidr_blocks       = ["",""] # web and app subnets
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

  ## ELB SG ##
    
    resource "aws_security_group" "elb-sg" {
      name        = "${var.sg-name-elb}-${terraform.workspace}-${lookup(var.protocol, elb)}"
      description = "ELB security group for ${var.template} in ${terraform.workspace} environment"
      vpc_id      = "${module.new-vpc.vpc-id}"

      tags = {
        Name          = "${var.sg-name-elb}-${terraform.workspace}-${lookup(var.protocol, elb)}"
        Template      = "${var.template}"
        Environment   = "${terraform.workpsace}"
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

  ## WEB SERVER SG ##

    resource "aws_security_group" "web-sg" {
      name        = "${var.sg-name-pri}-${terraform.workspace}-${lookup(var.protocol, web)}"
      description = "WEB security group for ${terraform.workspace} environment"
      vpc_id      = "${module.new-vpc.vpc-id}"

      tags = {
        Name          = "${var.sg-name-pri}-${terraform.workspace}-${lookup(var.protocol, web)}"
        Template      = "${var.template}"
        Environment   = "${terraform.workpsace}"
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
