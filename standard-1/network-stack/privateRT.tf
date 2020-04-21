module "privateRT" {
  source = "../../modules/rt"
  vpc-id = "${module.new-vpc.vpc-id}"
  rtName = "${var.privateRouteTable}"
  template = "${var.template}"
}

module "rtToPriSubnet1" {
  source       = "../../modules/rtAssociation"
  subnet-ids   = "${module.pri_subnet_1.subnet-id}"
  rt-id        = "${module.privateRT.rt-id}"
  subnet-cidrs = "${split(",",lookup(var.az1PrivateSubnetCidr, terraform.workspace))}"
}

module "rtToPriSubnet2" {
  source       = "../../modules/rtAssociation"
  subnet-ids   = "${module.pri_subnet_2.subnet-id}"
  rt-id        = "${module.privateRT.rt-id}"
  subnet-cidrs = "${split(",",lookup(var.az2PrivateSubnetCidr, terraform.workspace))}"
}