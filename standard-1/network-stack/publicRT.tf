module "publicRT" {
  source = "../../modules/rt"
  vpc-id = "${module.new-vpc.vpc-id}"
  rtName = "${var.publicRouteTable}"
  template = "${var.template}"
}

module "rtToPubSubnet1" {
  source       = "../../modules/rtAssociation"
  subnet-ids   = "${module.pub_subnet_1.subnet-id}"
  rt-id        = "${module.publicRT.rt-id}"
  subnet-cidrs = "${split(",",lookup(var.az1PublicSubnetCidr, terraform.workspace))}"
}

module "rtToPubSubnet2" {
  source       = "../../modules/rtAssociation"
  subnet-ids   = "${module.pub_subnet_2.subnet-id}"
  rt-id        = "${module.publicRT.rt-id}"
  subnet-cidrs = "${split(",",lookup(var.az2PublicSubnetCidr, terraform.workspace))}"
}

module "publicRoutes" {
  source       = "../../modules/route/"
  routeTableId = "${module.publicRT.rt-id}"
  destination  = "${var.destinationRoute}"
  igw          = "${module.igw-vpc.igw-id}"
}
