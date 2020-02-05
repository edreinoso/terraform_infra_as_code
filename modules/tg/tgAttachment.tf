##### Target Groups Attachment #####
# resource "aws_lb_target_group_attachment" "target-group" {
#   count            = "${length(split(",",var.tg-id))}"
#   target_group_arn = "${aws_lb_target_group.target-group.arn}"
#   target_id        = "${element(split(",",var.tg-id), count.index)}"
#   port             = "80"
# }
