# SSH SG
resource "aws_security_group" "internal-sg" {
  name        = "${var.sg-name-pri}-${terraform.workspace}-ssh"
  description = "Internal security group for application and web servers in ${terraform.workspace} environment"
  vpc_id      = "${element(data.terraform_remote_state.vpc.outputs.vpc-id, 1)}"

  tags = {
    Name          = "${var.sg-name-pri}-${terraform.workspace}-ssh"
    Template      = "${var.template}"
    Environment   = "${terraform.workspace}"
    Creation_Date = "${var.created-on}"
  }
}

resource "aws_security_group_rule" "internal-sg-rule-1" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.nat-sg.id}"
  security_group_id        = "${aws_security_group.internal-sg.id}"
}

resource "aws_security_group_rule" "internal-sg-rule-2" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.elb-sg.id}"
  security_group_id        = "${aws_security_group.internal-sg.id}"
}

resource "aws_security_group_rule" "internal-sg-rule-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.internal-sg.id}"
}
