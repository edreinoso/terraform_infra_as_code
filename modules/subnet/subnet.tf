resource "aws_subnet" "subnet" {
  count                   = "${length(var.subnet-cidr)}"
  vpc_id                  = "${var.vpc-id}"
  cidr_block              = "${element(var.subnet-cidr, count.index)}"
  availability_zone       = "${var.availability_zone}"
  map_public_ip_on_launch = "${var.visibility == "private" ? false : true }"

  tags = {
    Availability = "${var.subnet-availability}"
    Name    = "${element(var.subnet-name, count.index)}"
    Type    = "${var.type}"
    Template = "${var.template}"
  }
}
