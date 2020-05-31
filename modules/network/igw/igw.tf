resource "aws_internet_gateway" "igw" {
  vpc_id = "${var.vpc-id}"

  tags = {
    Name          = "${var.igwName}"
    Template      = "${var.template}"
    Environment   = "${var.environment}"
    Application   = "${var.application}"
    Purpose       = "${var.purpose}"
    Creation_Date = "${var.created-on}"
  }
}
