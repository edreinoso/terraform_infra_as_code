module "elb" {
  source         = "../../modules/elb"
  elb-name       = "${var.elb-name}"
  internal-elb   = "${var.internal-elb}"
  elb-type       = "${var.elb-type}"
  bucket-name    = "${var.bucket-name}"
  # change
  security-group = "${split(",", data.terraform_remote_state.network.outputs.elb-sg-id)}"
  subnet-ids     = ["${element(element(data.terraform_remote_state.network.outputs.pub-subnet-1-id, 1), 1)}", "${element(element(data.terraform_remote_state.network.outputs.pub-subnet-2-id, 1), 1)}"]
}

module "target-group" {
  source         = "../../modules/tg"
  elb-tg-name    = "${var.elb-tg-name}"
  tg-port        = "${var.tg-port}"
  tg-protocol    = "${var.tg-protocol}"
  tg-target-type = "${var.tg-target-type}"
  # change
  vpc-id         = "${element(data.terraform_remote_state.network.outputs.vpc-id, 1)}"
}

module "target-group-attachment" {
  source           = "../../modules/tgAttachment"
  tg-id            = "${module.web-server.ec2-id[0]}"
  port             = "${var.tg-port}"
  target-group-arn = "${module.target-group.target-arn}"
}

module "listener" {
  source            = "../../modules/listener"
  elb-arn           = "${module.elb.elb-arn}"
  listener-port     = "${var.tg-port}"
  listener-protocol = "${var.tg-protocol}"
  target-group-arn  = "${module.target-group.target-arn}"
}

resource "aws_s3_bucket" "s3" {
  bucket  = "${var.bucket-name}"
  acl     = "${var.acl}"
  force_destroy = "${var.destroy}"

  policy = <<POLICY
{
  "Id": "Policy1566872708101",
  "Version": "2012-10-17",
  "Statement": [
      {
          "Sid": "Stmt1566872706748",
          "Action": [
              "s3:PutObject"
          ],
          "Effect": "Allow",
          "Resource": "arn:aws:s3:::${var.bucket-name}/AWSLogs/${var.account-id}/*",
          "Principal": {
              "AWS": [
                  "127311923021"
              ]
          }
      }
  ]
}
POLICY

  tags = {
    Name = "${var.bucket-name}"
  }
}