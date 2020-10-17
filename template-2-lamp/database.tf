### RDS ###

  module "new-rds" {
    source                 = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/storage/rds"
    # optionals since we using snapshot identifier #
    allocated-storage      = "${var.storage}"  
    engine                 = "${var.engine}"   
    username               = "${var.username}" 
    password               = "${var.password}" 
    db-name                = "${var.db-name}"  
    # optionals since we using snapshot identifier #
    storage-type           = "${var.storage-type}"
    db-identifier          = "${var.rds-name}-${terraform.workspace}"
    final-snapshot         = "${var.final-snapshot}-${formatdate("MMMM-DD-YYYY-hh-mm-ss", timestamp())}"
    engine-version         = "${var.engine-version}"
    instance-class         = "${var.instance-class}"
    rds-name               = "${var.rds-name}-${terraform.workspace}-private"
    publicly-accessible    = "${var.publicly-accessible}"
    availability-zone      = "${var.AWS_REGIONS}"
    db-port                = "${var.db-port}"
    skip-final             = "${var.skip-final-snapshot}"
    db-subnet-group        = "${module.subnet-group-private.subnet-group-outputs}"
    vpc-security-group-ids = "${split(",", aws_security_group.db-pri-sg.id)}"
    tags = {
      Name          = "${var.rds-name}"
      Template      = "${var.template}"
      Environment   = "${terraform.workspace}"
      Application   = "${var.application}"
      Purpose       = "${var.purpose}"
      Creation_Date = "${var.created-on}"
    }
  }

### SUBNET GROUP ###

  module "subnet-group-private" {
    source      = "/Users/elchoco/aws/terraform_infrastructure_as_code/modules/storage/subnet-groups"
    name        = "${var.template}-${var.subnet-group-name}-${terraform.workspace}"
    # subnet-ids referencing DB subnets
    subnet-ids  = ["${element(module.pri_subnet_1.subnet-id, 3)}", "${element(module.pri_subnet_2.subnet-id, 3)}"]
    tags = {
      Name          = "${var.subnet-group-name}"
      Template      = "${var.template}"
      Environment   = "${terraform.workspace}"
      Application   = "${var.application}"
      Purpose       = "${var.purpose}"
      Creation_Date = "${var.created-on}"
    }
  }
