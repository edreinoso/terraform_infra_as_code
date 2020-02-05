module "nat-host" {
  source             = "../../modules/ec2-custom-ami"
  custom-ami         = "${var.custom-ami}"
  instance-type      = "${var.instance-type}"
  subnet-ids         = "${var.subnet-pub}"
  ec2-name           = "${var.ec2-name-pub-nat}"
  public-ip          = "${var.public-ip-association-true}"
  sourceCheck        = "${var.sourceCheck-disable}"
  key-name           = "${var.key-name-pub}"
  security-group-ids = "${split(",", var.security-groups-pub)}"
  template           = "${var.template}"
}

module "web-server" {
  source             = "../../modules/ec2"
  ami                = "${var.ami}"
  instance-type      = "${var.instance-type}"
  subnet-ids         = "${var.subnet-pri}"
  ec2-name           = "${var.ec2-name-web}"
  public-ip          = "${var.public-ip-association-false}"
  sourceCheck        = "${var.sourceCheck-enable}"
  key-name           = "${var.key-name-pri}"
  user-data          = "${file("build.sh")}"
  security-group-ids = "${split(",", var.security-groups-pri)}"
  template           = "${var.template}"
}
