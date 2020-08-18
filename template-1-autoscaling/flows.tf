# resource "aws_flow_log" "flow_logs" {
#   iam_role_arn             = aws_iam_role.role.arn
#   log_destination          = aws_cloudwatch_log_group.log_groups.arn
#   vpc_id                   = "${module.new-vpc.vpc-id}"
#   traffic_type             = var.traffic-type
#   max_aggregation_interval = var.max-aggregation-interval
#   tags = {
#     Environment   = "${terraform.workspace}"
#     Application   = "${var.application}"
#     Purpose       = "${var.purpose}"
#     Creation_Date = "${var.created-on}"
#     Template      = "${var.template}"
#     Name          = "flow-logs"
#   }
# }

# resource "aws_cloudwatch_log_group" "log_groups" {
#   name = "${var.log-destination}/${terraform.workspace}"
#   tags = {
#     Environment   = "${terraform.workspace}"
#     Application   = "${var.application}"
#     Purpose       = "${var.purpose}"
#     Creation_Date = "${var.created-on}"
#     Template      = "${var.template}"
#     Name          = "flow-logs"
#   }
# }

# resource "aws_iam_role" "role" {
#   name = var.role-name

#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Sid": "",
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "vpc-flow-logs.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# EOF
#   tags = {
#     Environment   = "${terraform.workspace}"
#     Application   = "${var.application}"
#     Purpose       = "${var.purpose}"
#     Creation_Date = "${var.created-on}"
#     Template      = "${var.template}"
#     Name          = "flow-logs"
#   }
# }

# resource "aws_iam_role_policy" "role_policy" {
#   name = var.role-policy-name
#   role = aws_iam_role.role.id

#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": [
#         "logs:CreateLogGroup",
#         "logs:CreateLogStream",
#         "logs:PutLogEvents",
#         "logs:DescribeLogGroups",
#         "logs:DescribeLogStreams"
#       ],
#       "Effect": "Allow",
#       "Resource": "*"
#     }
#   ]
# }
# EOF
# }
