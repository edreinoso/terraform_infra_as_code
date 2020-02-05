module "elb" {
  source         = "../../modules/elb"
  elb-name       = "${var.elb-name}"
  internal-elb   = "${var.internal-elb}"
  elb-type       = "${var.elb-type}"
  security-group = "${split(",", var.elb-sg)}"
  subnet-ids     = "${split(",", var.elb-subnets)}"
  bucket-name    = "${var.bucket-name}"
}

module "target-group" {
  source         = "../../modules/tg"
  elb-tg-name    = "${var.elb-tg-name}"
  tg-port        = "${var.tg-port}"
  tg-protocol    = "${var.tg-protocol}"
  tg-target-type = "${var.tg-target-type}"
  vpc-id         = "${var.vpc-id}"
}

module "target-group-attachment" {
  source           = "../../modules/tgAttachment"
  tg-id            = "${module.web-server.ec2-id[0]}"
  target-group-arn = "${module.target-group.target-arn}"
}

module "listener" {
  source            = "../../modules/listener"
  elb-arn           = "${module.elb.elb-arn}"
  listener-port     = "${var.tg-port}"
  listener-protocol = "${var.tg-protocol}"
  target-group-arn  = "${module.target-group.target-arn}"
}
