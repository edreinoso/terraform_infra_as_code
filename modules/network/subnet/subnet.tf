resource "aws_subnet" "subnet" {
  count                   = "${length(var.subnet-cidr)}"
  vpc_id                  = "${var.vpc-id}"
  cidr_block              = "${element(var.subnet-cidr, count.index)}"
  availability_zone       = "${var.availability_zone}"
  map_public_ip_on_launch = "${var.type == "private" ? false : true}"

  tags = {
    Availability  = "${var.subnet-availability}"
    Type          = "${var.type}"
    Name          = "${element(var.subnet-name, count.index)}"
    Template      = "${var.template}"
    Environment   = "${var.environment}"
    Application   = "${var.application}"
    Purpose       = "${var.purpose}"
    Creation_Date = "${var.created-on}"
  }
}
