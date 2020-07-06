module "new-rds" {
  source                 = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/storage/rds"
  allocated-storage      = "${var.storage}"  # optionals since we using snapshot identifier
  engine                 = "${var.engine}"   # optionals since we using snapshot identifier
  username               = "${var.username}" # optionals since we using snapshot identifier
  password               = "${var.password}" # optionals since we using snapshot identifier
  db-name                = "${var.db-name}"  # optionals since we using snapshot identifier`
  storage-type           = "${var.storage-type}"
  db-identifier          = "${var.template}-${terraform.workspace}"
  final-snapshot         = "${var.final-snapshot}-${formatdate("MMMM-DD-YYYY-hh-mm-ss", timestamp())}"
  engine-version         = "${var.engine-version}"
  instance-class         = "${var.instance-class}"
  rds-name               = "${var.rds-name}-${terraform.workspace}-private"
  publicly-accessible    = "${var.publicly-accessible}"
  availability-zone      = "us-east-1a"
  db-port                = "${var.db-port}"
  template               = "${var.template}"
  skip-final             = "${var.skip-final-snapshot}"
  db-subnet-group        = "${module.subnet-group-private.subnet-group-outputs}"
  vpc-security-group-ids = "${split(",", aws_security_group.db-pri-sg.id)}"
  # this needs to be changed
  # snapshot-identifier = "${var.snapshot-identifier}" # optional if building from snapshot
  # db-subnet-group        = "${aws_db_subnet_group.rds-subnet-group-private.id}"
  # vpc-security-group-ids = "${split(",", data.terraform_remote_state.security.outputs.database-sg-pri)}"
}

module "subnet-group-private" {
  source = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/storage/subnet-groups"
  name   = "${var.template}-${var.subnet-group-name}-${terraform.workspace}"
  # subnet-ids need to reference the network modules
  subnet-ids  = ["${element(module.pri_subnet_1.subnet-id, 3)}", "${element(module.pri_subnet_2.subnet-id, 3)}"]
  template    = "${var.template}"
  environment = "${terraform.workspace}"
}
