resource "aws_db_instance" "rds" {
  allocated_storage         = "${var.allocated-storage}"
  name                      = "${var.db-name}"
  storage_type              = "${var.storage-type}"
  engine                    = "${var.engine}"
  engine_version            = "${var.engine-version}"
  instance_class            = "${var.instance-class}"
  identifier                = "${var.db-identifier}"
  username                  = "${var.username}"
  password                  = "${var.password}" # need to have a secure way of keeping this
  parameter_group_name      = "${var.parameter-group-name}"
  db_subnet_group_name      = "${var.db-subnet-group}"
  publicly_accessible       = "${var.publicly-accessible}"
  availability_zone         = "${var.availability-zone}"
  vpc_security_group_ids    = "${var.vpc-security-group-ids}"
  port                      = "${var.db-port}"
  final_snapshot_identifier = "${var.final-snapshot}"
  snapshot_identifier       = "${var.snapshot-identifier}"

  tags = {
    Name        = "${var.rds-name}"
    Environment = "${terraform.workspace}"
    Template    = "${var.template}"
  }
}
