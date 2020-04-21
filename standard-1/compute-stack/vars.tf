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

#Web
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

variable "instance-role" {
  type    = "string"
  default = "EC2_Role"
}


variable "volume-size" {
  type    = "string"
  default = "8"
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

# Route Table Association to NAT
variable "destinationRoute" {
  type    = "string"
  default = "0.0.0.0/0"
}

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
  default = "load-balancer-logs-bucket"
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
