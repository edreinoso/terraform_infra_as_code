### VPC ###
  
  module "new-vpc" {
    source              = "../modules/network/vpc"
    vpc-cidr            = "${lookup(var.vpc-cidr, terraform.workspace)}"
    enable-dns-support  = "${var.vpc-dns-support}"
    enable-dns-hostname = "${var.vpc-dns-hostname}"
  }

### FLOW LOGS ###

  module "vpc-flow-logs" {
    source                   = "../modules/network/flow-log"
    vpc-id                   = "${module.new-vpc.vpc-id}"
    traffic-type             = "${var.traffic-type}"
    log-destination          = "${var.log-destination}"
    role-policy-name         = "${var.role-policy-name}"
    role-name                = "${var.role-name}"
    max-aggregation-interval = "${var.max-aggregation-interval}"
    #Tags
    tags = {
      Name          = "flow-logs"
      Environment   = "${terraform.workspace}"
      Template      = "${var.template}"
      Application   = "${var.application}"
      Purpose       = "${var.purpose}"
      Creation_Date = "${var.created-on}"
    }
  }

### SUBNETS ###
  
  ## PUBLIC subnet AZ 1 ##
  
    module "pub_subnet_1" {
      source              = "../modules/network/subnet"
      vpc-id              = "${module.new-vpc.vpc-id}"
      subnet-cidr         = "${split(",", lookup(var.az1PublicSubnetCidr, terraform.workspace))}"
      availability_zone   = "us-east-1a"
      visibility          = "${var.publicSubnet}"
      subnet-name         = "${split(",", lookup(var.az1PublicSubnetNames, terraform.workspace))}"
      template            = "${var.template}"
      subnet-availability = "${var.main-subnet}"
      type                = "${var.public-type}"
    }

  ## PUBLIC subnet AZ 2 ##
    
    module "pub_subnet_2" {
      source              = "../modules/network/subnet"
      vpc-id              = "${module.new-vpc.vpc-id}"
      subnet-cidr         = "${split(",", lookup(var.az2PublicSubnetCidr, terraform.workspace))}"
      availability_zone   = "us-east-1b"
      visibility          = "${var.publicSubnet}"
      subnet-name         = "${split(",", lookup(var.az2PublicSubnetNames, terraform.workspace))}"
      template            = "${var.template}"
      subnet-availability = "${var.ha-subnet}"
      type                = "${var.public-type}"
    }

  ## PRIVATE subnets AZ 1 ##
    
    module "pri_subnet_1" {
      source              = "../modules/network/subnet"
      vpc-id              = "${module.new-vpc.vpc-id}"
      subnet-cidr         = "${split(",", lookup(var.az1PrivateSubnetCidr, terraform.workspace))}"
      availability_zone   = "us-east-1a"
      visibility          = "${var.privateSubnet}"
      subnet-name         = "${split(",", lookup(var.az1PrivateSubnetNames, terraform.workspace))}"
      template            = "${var.template}"
      subnet-availability = "${var.main-subnet}"
      type                = "${var.private-type}"
    }

  ## PUBLIC subnets AZ 2 ##
    
    module "pri_subnet_2" {
      source              = "../modules/network/subnet"
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
    source   = "../modules/network/igw"
    vpc-id   = "${module.new-vpc.vpc-id}"
    igwName  = "${var.igw-name}"
    template = "${var.template}"
  }

### ROUTE TABLES ###
  
  module "privateRT" {
    source   = "../modules/network/route-tables/rt"
    vpc-id   = "${module.new-vpc.vpc-id}"
    rtName   = "${var.privateRouteTable}"
    template = "${var.template}"
  }

  module "rtToPriSubnet1" {
    source       = "../modules/network/route-tables/rtAssociation"
    subnet-ids   = "${module.pri_subnet_1.subnet-id}"
    rt-id        = "${module.privateRT.rt-id}"
    subnet-cidrs = "${split(",", lookup(var.az1PrivateSubnetCidr, terraform.workspace))}"
  }

  module "rtToPriSubnet2" {
    source       = "../modules/network/route-tables/rtAssociation"
    subnet-ids   = "${module.pri_subnet_2.subnet-id}"
    rt-id        = "${module.privateRT.rt-id}"
    subnet-cidrs = "${split(",", lookup(var.az2PrivateSubnetCidr, terraform.workspace))}"
  }

  module "publicRT" {
    source   = "../modules/network/route-tables/rt"
    vpc-id   = "${module.new-vpc.vpc-id}"
    rtName   = "${var.publicRouteTable}"
    template = "${var.template}"
  }

  module "rtToPubSubnet1" {
    source       = "../modules/network/route-tables/rtAssociation"
    subnet-ids   = "${module.pub_subnet_1.subnet-id}"
    rt-id        = "${module.publicRT.rt-id}"
    subnet-cidrs = "${split(",", lookup(var.az1PublicSubnetCidr, terraform.workspace))}"
  }

  module "rtToPubSubnet2" {
    source       = "../modules/network/route-tables/rtAssociation"
    subnet-ids   = "${module.pub_subnet_2.subnet-id}"
    rt-id        = "${module.publicRT.rt-id}"
    subnet-cidrs = "${split(",", lookup(var.az2PublicSubnetCidr, terraform.workspace))}"
  }

  module "publicRoutes" {
    source       = "../modules/network/route-tables/route/"
    routeTableId = "${module.publicRT.rt-id}"
    destination  = "${var.destinationRoute}"
    igw          = "${module.igw-vpc.igw-id}"
  }
