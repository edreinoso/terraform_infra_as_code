# Security Group
variable "sg-name-pub" {
  type    = "string"
  default = "pub"
}

variable "sg-name-pri" {
  type    = "string"
  default = "pri"
}

variable "sg-name-elb" {
  type    = "string"
  default = "elb"
}

variable "ips" {
  type    = "string"
  default = "100.12.75.72/32" # your IP addresses that you want to provide access to your infrastructure
}
