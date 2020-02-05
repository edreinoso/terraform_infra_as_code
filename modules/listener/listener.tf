###### Listeners #####
resource "aws_lb_listener" "listener" {
  load_balancer_arn = "${var.elb-arn}"
  port              = "${var.listener-port}"
  protocol          = "${var.listener-protocol}"
  # ssl_policy        = "ELBSecurityPolicy-2016-08"
  # certificate_arn   = "${var.certArn}"


  default_action {
    # target_group_arn = "${aws_lb_target_group.target-group.arn}"
    target_group_arn = "${var.target-group-arn}"
    type             = "forward"
  }
}