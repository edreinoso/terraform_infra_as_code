##### Target Groups Attachment #####
resource "aws_lb_target_group_attachment" "target-group" {
  target_group_arn = var.target_group_arn
  target_id        = var.tg_id
  port             = var.port
}
