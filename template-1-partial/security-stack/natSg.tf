# SSH SG
resource "aws_security_group" "nat-sg" {
  name        = "${var.sg-name-pub}-${terraform.workspace}-ssh"
  description = "Bastion security group for ${terraform.workspace} environment"
  vpc_id      = "${element(data.terraform_remote_state.vpc.outputs.vpc-id, 1)}"

  tags = {
    Name          = "${var.sg-name-pub}-${terraform.workspace}-ssh"
    Template      = "${var.template}"
    Environment   = "${terraform.workspace}"
    Creation_Date = "${var.created-on}"
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
