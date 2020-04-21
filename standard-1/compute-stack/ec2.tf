data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "terraform-state-er"
    key    = "env:/dev/standard-1/network-terraform.tfstate"
    region = "us-east-1"
  }
}

module "nat-host" {
  source        = "../../modules/ec2-custom-ami"
  custom-ami    = "${var.custom-ami}"
  instance-type = "${var.instance-type}"
  ec2-name      = "${var.ec2-name-pub-nat}"
  public-ip     = "${var.public-ip-association-true}"
  sourceCheck   = "${var.sourceCheck-disable}"
  key-name      = "${var.key-name-pub}"
  volume-size   = "${var.volume-size}"
  instance-role = "${var.instance-role}"
  template      = "${var.template}"
  # change
  subnet-ids         = "${element(element(data.terraform_remote_state.network.outputs.pub-subnet-1-id, 1), 1)}"
  security-group-ids = "${split(",", data.terraform_remote_state.network.outputs.public-sg-id)}"
}

module "publicRoutes" {
  source = "../../modules/route/"
  # change, dynamic
  routeTableId = "${element(data.terraform_remote_state.network.outputs.pri-route-table, 1)}"
  destination  = "${var.destinationRoute}"
  instanceId   = "${element(module.nat-host.ec2-id, 1)}"
}

#this case would be APP instead of web
module "web-server" {
  source        = "../../modules/ec2"
  ami           = "${var.ami}"
  instance-type = "${var.instance-type}"
  ec2-name      = "${var.ec2-name-web}"
  public-ip     = "${var.public-ip-association-false}"
  sourceCheck   = "${var.sourceCheck-enable}"
  key-name      = "${var.key-name-pri}"
  # volume-size   = "${var.volume-size}"
  instance-role = "${var.instance-role}"
  user-data     = "${file("build.sh")}"
  template      = "${var.template}"
  # change
  subnet-ids         = "${element(element(data.terraform_remote_state.network.outputs.pri-subnet-1-id, 0), 0)}"
  security-group-ids = "${split(",", data.terraform_remote_state.network.outputs.private-sg-id)}"
}
