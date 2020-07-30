# resource "aws_autoscaling_policy" "bat" {
#   name                   = "foobar3-terraform-test"
#   scaling_adjustment     = 4
#   adjustment_type        = "ChangeInCapacity"
#   cooldown               = 300
#   autoscaling_group_name = "${aws_autoscaling_group.bar.name}"
# }