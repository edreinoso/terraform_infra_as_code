# EC2
#Web | NAT
variable "ami" {
  type    = "string"
  default = ""
}

variable "custom-ami" {
  type    = "string"
  default = ""
}

variable "instance-type" {
  type    = "string"
  default = "t2.micro"
}

variable "public-ip-association-true" {
  type    = "string"
  default = "true"
}

variable "sourceCheck-enable" {
  type = "string"
  default = "true"
}

variable "sourceCheck-disable" {
  type = "string"
  default = ""
}

variable "public-ip-association-false" {
  type    = "string"
  default = ""
}

variable "ec2-name-pub-nat" {
  type    = "string"
  default = "nat-host"
}

variable "ec2-name-pri-web" {
  type    = "string"
  default = "web-server"
}

variable "key-name-pub" {
  type    = "string"
  default = "base-template"
}

variable "key-name-pri" {
  type    = "string"
  default = "internal-base-template"
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

variable "tg-deregister" {
  type = "string"

  # monitor for change
  default = "400"
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
  default = "" # your account ID
}
