module "igw-vpc" {
  source  = "../../modules/igw"
  vpc-id  = "${module.new-vpc.vpc-id}"
  igwName = "${var.igw-name}"
  template = "${var.template}"
}
