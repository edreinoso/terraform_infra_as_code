resource "aws_lb" "elb" {
  # count              = "${length(var.subnet-ids)}"
  name               = "${var.elb-name}"
  internal           = "${var.internal-elb}"
  load_balancer_type = "${var.elb-type}"
  security_groups    = "${var.security-group}"
  # subnets            = "${element(split(",", var.subnet-ids), count.index)}"
  # subnets            = "${element(var.subnet-ids, count.index)}"
  # subnets            = ["${split(",",var.subnet-ids)}"]
  # subnets            = ["${var.subnet-ids}"]
  subnets            = "${var.subnet-ids}"
  
  access_logs {
    bucket  = "${var.bucket-name}"
    prefix  = ""
    enabled = true
  }

  tags = {
    Name        = "${var.elb-name}"
    Environment = "${terraform.workspace}"
    Template    = "${var.template}"
  }
}
