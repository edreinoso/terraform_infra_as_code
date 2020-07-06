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

variable "sg-name-db-pri" {
  type    = "string"
  default = "database-sg-private"
}

variable "ips" {
  type    = "string"
  default = "71.113.186.65/32"
}
