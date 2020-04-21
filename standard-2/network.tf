### VPC ###
module "new-vpc" {
  source              = "../modules/vpc"
  vpc-cidr            = "${lookup(var.vpc-cidr, terraform.workspace)}"
  vpc-name            = "${lookup(var.vpc-name, terraform.workspace)}"
  template            = "${var.template}"
  enable-dns-support  = "${var.vpc-dns-support}"
  enable-dns-hostname = "${var.vpc-dns-hostname}"
}

### SUBNETS ###

# # Public subnet where the potential web server instances/bastion hosts will be created
# AZ 1
module "pub_subnet_1" {
  source              = "../modules/subnet"
  vpc-id              = "${module.new-vpc.vpc-id}"
  subnet-cidr         = "${split(",", lookup(var.az1PublicSubnetCidr, terraform.workspace))}"
  availability_zone   = "us-east-1a"
  visibility          = "${var.publicSubnet}"
  subnet-name         = "${split(",", lookup(var.az1PublicSubnetNames, terraform.workspace))}"
  template            = "${var.template}"
  subnet-availability = "${var.main-subnet}"
  type                = "${var.public-type}"
}

# AZ 2
module "pub_subnet_2" {
  source              = "../modules/subnet"
  vpc-id              = "${module.new-vpc.vpc-id}"
  subnet-cidr         = "${split(",", lookup(var.az2PublicSubnetCidr, terraform.workspace))}"
  availability_zone   = "us-east-1b"
  visibility          = "${var.publicSubnet}"
  subnet-name         = "${split(",", lookup(var.az2PublicSubnetNames, terraform.workspace))}"
  template            = "${var.template}"
  subnet-availability = "${var.ha-subnet}"
  type                = "${var.public-type}"
}

# Private subnets where the potential app instances / db instances
# AZ 1
module "pri_subnet_1" {
  source              = "../modules/subnet"
  vpc-id              = "${module.new-vpc.vpc-id}"
  subnet-cidr         = "${split(",", lookup(var.az1PrivateSubnetCidr, terraform.workspace))}"
  availability_zone   = "us-east-1a"
  visibility          = "${var.privateSubnet}"
  subnet-name         = "${split(",", lookup(var.az1PrivateSubnetNames, terraform.workspace))}"
  template            = "${var.template}"
  subnet-availability = "${var.main-subnet}"
  type                = "${var.private-type}"
}

# AZ 2
module "pri_subnet_2" {
  source              = "../modules/subnet"
  vpc-id              = "${module.new-vpc.vpc-id}"
  subnet-cidr         = "${split(",", lookup(var.az2PrivateSubnetCidr, terraform.workspace))}"
  availability_zone   = "us-east-1b"
  visibility          = "${var.privateSubnet}"
  subnet-name         = "${split(",", lookup(var.az2PrivateSubnetNames, terraform.workspace))}"
  template            = "${var.template}"
  subnet-availability = "${var.ha-subnet}"
  type                = "${var.private-type}"
}

### INTERNET GATEWAY ###
module "igw-vpc" {
  source   = "../modules/igw"
  vpc-id   = "${module.new-vpc.vpc-id}"
  igwName  = "${var.igw-name}"
  template = "${var.template}"
}

### ROUTE TABLES ###
module "privateRT" {
  source   = "../modules/rt"
  vpc-id   = "${module.new-vpc.vpc-id}"
  rtName   = "${var.privateRouteTable}"
  template = "${var.template}"
}

module "rtToPriSubnet1" {
  source       = "../modules/rtAssociation"
  subnet-ids   = "${module.pri_subnet_1.subnet-id}"
  rt-id        = "${module.privateRT.rt-id}"
  subnet-cidrs = "${split(",", lookup(var.az1PrivateSubnetCidr, terraform.workspace))}"
}

module "rtToPriSubnet2" {
  source       = "../modules/rtAssociation"
  subnet-ids   = "${module.pri_subnet_2.subnet-id}"
  rt-id        = "${module.privateRT.rt-id}"
  subnet-cidrs = "${split(",", lookup(var.az2PrivateSubnetCidr, terraform.workspace))}"
}

module "privateRoutes" {
  source       = "../modules/route/"
  routeTableId = "${module.privateRT.rt-id}"
  destination  = "${var.destinationRoute}"
  instanceId   = "${element(module.nat-ec2.ec2-id, 1)}" # need to test whether this is going to work
}

module "publicRT" {
  source   = "../modules/rt"
  vpc-id   = "${module.new-vpc.vpc-id}"
  rtName   = "${var.publicRouteTable}"
  template = "${var.template}"
}

module "rtToPubSubnet1" {
  source       = "../modules/rtAssociation"
  subnet-ids   = "${module.pub_subnet_1.subnet-id}"
  rt-id        = "${module.publicRT.rt-id}"
  subnet-cidrs = "${split(",", lookup(var.az1PublicSubnetCidr, terraform.workspace))}"
}

module "rtToPubSubnet2" {
  source       = "../modules/rtAssociation"
  subnet-ids   = "${module.pub_subnet_2.subnet-id}"
  rt-id        = "${module.publicRT.rt-id}"
  subnet-cidrs = "${split(",", lookup(var.az2PublicSubnetCidr, terraform.workspace))}"
}

module "publicRoutes" {
  source       = "../modules/route/"
  routeTableId = "${module.publicRT.rt-id}"
  destination  = "${var.destinationRoute}"
  igw          = "${module.igw-vpc.igw-id}"
}
