module "igw-vpc" {
  source = "../../modules/network/igw"
  vpc-id = "${module.new-vpc.vpc-id}"
  #TAGS
  igwName    = "${var.igw-name}"
  template   = "${var.template}"
  created-on = "${var.created-on}"
}
