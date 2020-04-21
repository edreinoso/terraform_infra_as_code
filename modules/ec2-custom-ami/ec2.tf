
#custom ami needs to come into place
#use case: NAT instance will be span up from this module

data "aws_ami" "custom_ami" {
  filter {
    name   = "name"
    values = ["${var.custom-ami}"]
  } 
  owners = ["self"]
}

resource "aws_instance" "ec2" {
  ami                         = "${data.aws_ami.custom_ami.id}"
  instance_type               = "${var.instance-type}"
  subnet_id                   = "${var.subnet-ids}"
  key_name                    = "${var.key-name}"
  iam_instance_profile        = "${var.instance-role}"

  associate_public_ip_address = "${var.public-ip == "" ? false : true}"
  source_dest_check           = "${var.sourceCheck == "" ? false : true}"
  vpc_security_group_ids      = "${var.security-group-ids}"
  
  tags = {
    Name        = "${var.ec2-name}"
    Environment = "${terraform.workspace}"
    Template    = "${var.template}"
  }

  # ebs_block_device {
  #   device_name = "${var.ec2-name}"
  #   volume_size = "${var.volume-size}"
  # }
}
