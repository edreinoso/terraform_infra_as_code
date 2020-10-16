# Security Group
variable "sg-name-pub" {
  type    = "string"
  default = ""
}

variable "sg-name-pri" {
  type    = "string"
  default = ""
}

variable "sg-name-elb" {
  type    = "string"
  default = ""
}

variable "ips" {
  type    = "string"
  default = "" # your IP addresses that you want to provide access to your infrastructure
}
