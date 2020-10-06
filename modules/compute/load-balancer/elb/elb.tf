resource "aws_lb" "elb" {
  name               = "${var.elb-name}"
  internal           = "${var.internal-elb}"
  load_balancer_type = "${var.elb-type}"
  security_groups    = "${var.security-group}"
  subnets            = "${var.subnet-ids}"
  
  access_logs {
    bucket  = "${var.bucket-name}"
    prefix  = ""
    enabled = true
  }

  # tags = {
  #   Name          = "${var.elb-name}"
  #   Environment   = "${var.environment}"
  #   Template      = "${var.template}"
  #   Application   = "${var.application}"
  #   Creation_Date = "${var.created-on}"
  #   Purpose       = "${var.purpose}"
  # }

  tags = merge(
    var.tags,
    var.lb_tags,
  )
}
