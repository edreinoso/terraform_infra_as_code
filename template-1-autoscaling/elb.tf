## ELB ##
module "elb" {
  source         = "../modules/compute/load-balancer/elb"
  elb-name       = "${var.elb-name}"
  internal-elb   = "${var.internal-elb}"
  elb-type       = "${var.elb-type}"
  security-group = "${split(",", aws_security_group.elb-sg.id)}"
  subnet-ids     = ["${element(module.pub_subnet_1.subnet-id,1)}","${element(module.pub_subnet_2.subnet-id,1)}"]
  bucket-name    = "${var.bucket-name}"
  environment    = "${terraform.workspace}"
  template       = "${var.template}"
  application    = "${var.application}"
  purpose        = "${var.purpose}"
  created-on     = "${var.created-on}"
}

module "target-group" {
  source         = "../modules/compute/load-balancer/tg"
  elb-tg-name    = "${var.elb-tg-name}"
  tg-port        = "${var.tg-port}"
  deregistration = "${var.tg-deregister}"
  tg-protocol    = "${var.tg-protocol}"
  tg-target-type = "${var.tg-target-type}"
  vpc-id         = "${module.new-vpc.vpc-id}"
}


module "listener" {
  source            = "../modules/compute/load-balancer/listener"
  elb-arn           = "${module.elb.elb-arn}"
  listener-port     = "${var.tg-port}"
  listener-protocol = "${var.tg-protocol}"
  target-group-arn  = "${module.target-group.target-arn}"
}

# module "target-group-attachment" {
#   source           = "../modules/compute/load-balancer/tgAttachment"
#   tg-id            = "${element(module.web-server.ec2-id, 1)}" # would have to register this somehow
#   target-group-arn = "${module.target-group.target-arn}"
#   port             = "${var.tg-port}"
# }