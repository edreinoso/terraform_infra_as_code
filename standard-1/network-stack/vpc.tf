module "new-vpc" {
  source              = "../../modules/vpc"
  vpc-cidr            = "${lookup(var.vpc-cidr, terraform.workspace)}"
  vpc-name            = "${lookup(var.vpc-name, terraform.workspace)}"
  template            = "${var.template}"
  enable-dns-support  = "${var.vpc-dns-support}"
  enable-dns-hostname = "${var.vpc-dns-hostname}"
}
