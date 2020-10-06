###### Target Groups #####
resource "aws_lb_target_group" "target-group" {
  name                 = "${var.elb-tg-name}"
  port                 = "${var.tg-port}"
  protocol             = "${var.tg-protocol}"
  target_type          = "${var.tg-target-type}"
  vpc_id               = "${var.vpc-id}"
  deregistration_delay = "${var.deregistration}"

  tags = merge(
    var.tags,
    var.target_group_tags,
  )

  #   tags = merge(
  #   var.tags,
  #   var.target_group_tags,
  #   lookup(var.target_groups[count.index], "tags", {}),
  #   {
  #     "Name" = lookup(var.target_groups[count.index], "name", lookup(var.target_groups[count.index], "name_prefix", ""))
  #   },
  # )
}
