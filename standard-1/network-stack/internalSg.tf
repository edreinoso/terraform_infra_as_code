# SSH SG
resource "aws_security_group" "internal-sg" {
  name        = "${var.sg-name-pri}-${lookup(var.environment, terraform.workspace)}-ssh"
  description = "SSH security group for ${lookup(var.environment, terraform.workspace)} environment"
  vpc_id      = "${module.new-vpc.vpc-id}"

  tags = {
    Name = "${var.sg-name-pri}-${lookup(var.environment, terraform.workspace)}-ssh"
    Template = "${var.template}"
  }
}

resource "aws_security_group_rule" "internal-sg-rule-1" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
  source_security_group_id = "${aws_security_group.nat-sg.id}"
  security_group_id = "${aws_security_group.internal-sg.id}"
}

resource "aws_security_group_rule" "internal-sg-rule-2" {
  type      = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
  source_security_group_id = "${aws_security_group.elb-sg.id}"
  security_group_id = "${aws_security_group.internal-sg.id}"
}

resource "aws_security_group_rule" "internal-sg-rule-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.internal-sg.id}"
}
