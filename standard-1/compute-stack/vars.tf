variable "AWS_REGIONS" {
  default = "us-east-1"
}

#Environment
variable "environment" {
  type = "map"

  default = {
    dev = "dev"
  }
}

variable "template" {
  type    = "string"
  default = "standard-1"
}

variable "vpc-id" {
  type    = "string"
  default = "vpc-0f32b4aa835563041"
}

#EC2 Components
variable "ami" {
  type    = "string"
  default = "ami-0b898040803850657"
}

variable "custom-ami" {
  type    = "string"
  default = "NAT-Instance-AMI"
}

variable "instance-type" {
  type    = "string"
  default = "t2.micro"
}

variable "public-ip-association-true" {
  type    = "string"
  default = "true"
}

variable "public-ip-association-false" {
  type    = "string"
  default = ""
}

variable "sourceCheck-enable" {
  type    = "string"
  default = "true"
}

variable "sourceCheck-disable" {
  type    = "string"
  default = ""
}

#Web | nat
variable "ec2-name-pub-nat" {
  type    = "string"
  default = "nat-host"
}

variable "ec2-name-web" {
  type    = "string"
  default = "web-server"
}

variable "key-name-pub" {
  type    = "string"
  default = "base-template"
}

variable "subnet-pub" {
  type    = "string"
  default = "subnet-0ada7236d2467ab18"
}

variable "security-groups-pub" {
  type    = "string"
  default = "sg-007276f39035f5ac9"
}

#App
variable "ec2-name-pri" {
  type    = "string"
  default = "app-server"
}

variable "key-name-pri" {
  type    = "string"
  default = "internal-base-template"
}

variable "subnet-pri" {
  type    = "string"
  default = "subnet-0ef4f173c44d59b1e"
}

variable "security-groups-pri" {
  type    = "string"
  default = "sg-0960179dd41021b55"
}

# Route Table Association to NAT
variable "routeTableId" {
  type    = "string"
  default = "rtb-04a76028fc10e8e6f"
}

variable "destinationRoute" {
  type    = "string"
  default = "0.0.0.0/0"
}

## --> for later use
# Load Balancers
variable "elb-name" {
  type    = "string"
  default = "sample-elb"
}

variable "elb-type" {
  type    = "string"
  default = "application"
}

variable "internal-elb" {
  type    = "string"
  default = "false"
}

variable "elb-subnets" {
  type    = "string"
  default = "subnet-0ada7236d2467ab18,subnet-03703091f5ad612cc"
}

variable "elb-sg" {
  type    = "string"
  default = "sg-00ac5dbf45a445334"
}

variable "elb-tg-name" {
  type = "string"
  default = "sample-target-group"
}

variable "tg-port" {
  type    = "string"
  default = "80"
}

variable "tg-protocol" {
  type    = "string"
  default = "HTTP"
}

variable "tg-target-type" {
  type    = "string"
  default = "instance"
}

# S3
variable "bucket-name" {
  type    = "string"
  default = "sample-load-balancer-logs-bucket"
}

variable "acl" {
  type    = "string"
  default = "private"
}

variable "destroy" {
  type    = "string"
  default = "true"
}

variable "account-id" {
  type    = "string"
  default = "130193131803"
}
