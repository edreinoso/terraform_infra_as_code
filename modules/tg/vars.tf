
variable "elb-tg-name" {
  type    = "string"
  default = ""
}

variable "vpc-id" {
  type    = "string"
  default = ""
}

# Not necessary at the moment. It's more necessary at the
# target group association

variable "tg-port" {
  type    = "string"
  default = ""
}

variable "tg-protocol" {
  type    = "string"
  default = ""
}

variable "tg-target-type" {
  type    = "string"
  default = ""
}

variable "deregistration" {
  type    = "string"
  default = ""
}
