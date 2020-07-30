module "example" {
  source = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/compute/autoscaling"

  name = "${var.autoscaling-name}-${terraform.workspace}"

  # Launch configuration
  #
  # launch_configuration = "my-existing-launch-configuration" # Use the existing launch configuration
  # create_lc = false # disables creation of launch configuration
  lc_name                      = "${var.launch-configuration-name}-${terraform.workspace}"
  image_id                     = "${var.ami}"
  instance_type                = "${var.instance-type}"
  security_groups              = "${split(",", aws_security_group.nat-sg.id)}" #
  associate_public_ip_address  = true
  recreate_asg_when_lc_changes = true
  user_data_base64             = base64encode("${file("build.sh")}")
  key_name                     = "${var.key-name-pub}"
  ebs_block_device = [
    {
      device_name           = "/dev/xvdk"
      volume_type           = "gp2"
      volume_size           = "50"
      delete_on_termination = true
    },
  ]
  root_block_device = [
    {
      volume_size           = "50"
      volume_type           = "gp2"
      delete_on_termination = true
    },
  ]

  # Auto scaling group
  asg_name                  = "${var.autoscaling-name}-${terraform.workspace}"
  vpc_zone_identifier       = ["${element(module.pub_subnet_2.subnet-id, 1)}", "${element(module.pub_subnet_1.subnet-id, 1)}"]
  health_check_type         = "${var.health-check}"
  desired_capacity          = 1
  min_size                  = 1
  max_size                  = 2
  wait_for_capacity_timeout = 0
  enabled_metrics           = "${var.enabled_metrics}"
  # service_linked_role_arn   = "${var.role}"

  tags = [
    {
      key                 = "Environment"
      value               = "${terraform.workspace}"
      propagate_at_launch = true
    },
    {
      key                 = "Template"
      value               = "${var.template}"
      propagate_at_launch = true
    },
    {
      key                 = "Creation Date"
      value               = "${var.created-on}"
      propagate_at_launch = true
    },
    {
      key                 = "Purpose"
      value               = "${var.purpose}"
      propagate_at_launch = true
    },
    {
      key                 = "Application"
      value               = "${var.application}"
      propagate_at_launch = true
    },
    {
      key                 = "Name"
      value               = "${var.autoscaling-name}"
      propagate_at_launch = true
    },
  ]

  # tags_as_map = {
  #   extra_tag1 = "extra_value1"
  #   extra_tag2 = "extra_value2"
  # }
}
