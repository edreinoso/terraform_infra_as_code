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

#only challenge I see here is the creation of routes before the instance
#this cannot of course happen at this layer because we'd be working on
#two different folders. One folder cannot relate to the other one.

# module "privateRoutes" {
#   source       = "../../modules/route/"
#   routeTableId = "${module.publicRT.rt-id}"
#   destination  = "${var.destinationRoute}"
#   igw          = "${module.igw-vpc.igw-id}"
# }