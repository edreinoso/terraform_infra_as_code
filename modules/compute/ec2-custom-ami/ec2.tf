# custom ami needs to come into place
# use case: NAT instance will be span up from this module

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

  volume_tags = {
    Name          = "${var.ec2-name}"
    Environment   = "${terraform.workspace}"
    Template      = "${var.template}"
    Application   = "${var.application}"
    Purpose       = "${var.purpose}"
    Creation_Date = "${var.created-on}"
  }

  dynamic "ebs_block_device" {
    for_each = var.ebs_block_device
    content {
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", null)
      device_name           = ebs_block_device.value.device_name
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", null)
      iops                  = lookup(ebs_block_device.value, "iops", null)
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
      encrypted             = lookup(ebs_block_device.value, "encrypted", null)
      kms_key_id            = lookup(ebs_block_device.value, "kms_key_id", null)
    }
  }
}
