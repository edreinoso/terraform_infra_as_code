## EC2 ##

#this module has to be configured to get the custom AMI for NAT
module "nat-ec2" {
  source             = "../modules/compute/ec2-custom-ami"
  custom-ami         = "${var.custom-ami}"
  instance-type      = "${var.instance-type}"
  subnet-ids         = "${element(module.pub_subnet_1.subnet-id, 1)}" # variable from code
  ec2-name           = "${var.ec2-name-pub-nat}"
  template           = "${var.template}"
  public-ip          = "${var.public-ip-association-true}"
  sourceCheck        = "${var.sourceCheck-disable}"
  key-name           = "${var.key-name-pub}"
  security-group-ids = "${split(",", aws_security_group.nat-sg.id)}" # variable from code
}

# web server in a private subnet
module "web-server" {
  source             = "../modules/compute/ec2"
  ami                = "${var.ami}"
  instance-type      = "${var.instance-type}"
  subnet-ids         = "${element(module.pri_subnet_1.subnet-id, 1)}"
  ec2-name           = "${var.ec2-name-pri-web}"
  template           = "${var.template}"
  key-name           = "${var.key-name-pri}"
  public-ip          = "${var.public-ip-association-false}"
  sourceCheck        = "${var.sourceCheck-enable}"
  security-group-ids = "${split(",", aws_security_group.web-sg.id)}"
  user-data          = "${file("build.sh")}"
}

## ELB ##

module "elb" {
  source         = "../modules/compute/load-balancer/elb"
  elb-name       = "${var.elb-name}"
  internal-elb   = "${var.internal-elb}"
  elb-type       = "${var.elb-type}"
  security-group = "${split(",", aws_security_group.elb-sg.id)}"
  # this is where the difficult part lies
  # trying to get terraform to know which subnest the ELB should go
  # the ELB needs to be highly available. Hence it needs to span 
  # between 2 different subnets.

  subnet-ids     = ["${element(module.pub_subnet_1.subnet-id,1)}","${element(module.pub_subnet_2.subnet-id,1)}"]
  template    = "${var.template}"
  bucket-name = "${var.bucket-name}"
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

module "target-group-attachment" {
  source           = "../modules/compute/load-balancer/tgAttachment"
  tg-id            = "${element(module.web-server.ec2-id, 1)}"
  target-group-arn = "${module.target-group.target-arn}"
  port             = "${var.tg-port}"
}

module "listener" {
  source            = "../modules/compute/load-balancer/listener"
  elb-arn           = "${module.elb.elb-arn}"
  listener-port     = "${var.tg-port}"
  listener-protocol = "${var.tg-protocol}"
  target-group-arn  = "${module.target-group.target-arn}"
}
