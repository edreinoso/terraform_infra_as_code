module "new-vpc" {
  source              = "../../modules/network/vpc"
  vpc-cidr            = "${lookup(var.vpc-cidr, terraform.workspace)}"
  enable-dns-support  = "${var.vpc-dns-support}"
  enable-dns-hostname = "${var.vpc-dns-hostname}"
  #TAGS
  vpc-name            = "${lookup(var.vpc-name, terraform.workspace)}"
  template            = "${var.template}"
  created-on          = "${var.created-on}"
}
