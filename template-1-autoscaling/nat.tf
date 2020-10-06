data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["130193131803"]

  filter {
    name = "name"
    values = [
      "NAT_amazon_linux",
    ]
  }

  filter {
    name = "owner-alias"
    values = [
      "ed-reinoso",
    ]
  }
}

## EC2 ##

#this module has to be configured to get the custom AMI for NAT
module "nat-ec2" {
  source             = "../modules/compute/ec2"
  custom-ami         = "${data.aws_ami.amazon_linux.id}"
  instance-type      = "${var.instance-type}"
  public-ip          = "${var.public-ip-association-true}"
  sourceCheck        = "${var.sourceCheck-disable}"
  key-name           = "${var.key-name-pub}"
  subnet-ids         = "${element(module.pub_subnet_2.subnet-id, 1)}"
  security-group-ids = "${split(",", aws_security_group.nat-sg.id)}"
  tags = {
    Name          = ""
    Template      = ""
    Environment   = ""
    Application   = ""
    Purpose       = ""
    Creation_Date = ""
  }
}
