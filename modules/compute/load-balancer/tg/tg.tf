###### Target Groups #####
resource "aws_lb_target_group" "target-group" {
  name                 = var.elb-tg-name
  port                 = var.tg-port
  protocol             = var.tg-protocol
  target_type          = var.tg-target-type
  vpc_id               = var.vpc-id
  deregistration_delay = var.deregistration

  health_check {
    health_cheks_path     = var.path
    health_cheks_port     = var.tg-port
    health_cheks_protocol = var.tg-protocol
  }

  tags = var.tags
}
