#aws amazon amis
#use case: where instance name is not easily located

resource "aws_instance" "ec2" {
  ami                         = "${var.ami}"
  instance_type               = "${var.instance-type}"
  subnet_id                   = "${var.subnet-ids}"
  key_name                    = "${var.key-name}"
  vpc_security_group_ids      = "${var.security-group-ids}"
  user_data                   = "${var.user-data}"
  iam_instance_profile        = "${var.instance-role}"
  associate_public_ip_address = "${var.public-ip == "" ? false : true}"
  source_dest_check           = "${var.sourceCheck == "" ? false : true}"


  tags = {
    Name          = "${var.ec2-name}"
    Environment   = "${terraform.workspace}"
    Template      = "${var.template}"
    Application   = "${var.application}"
    Purpose       = "${var.purpose}"
    Creation_Date = "${var.created-on}"
  }

  # ebs_block_device {
  #   device_name = "${var.ec2-name}"
  #   volume_size = "${var.volume-size}"
  # }
}
