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
  default = "load-balancer-logs-elb-ed"
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
  default = "130193131803" # your account ID
}
