variable "AWS_REGIONS" {
  default = "us-east-1"
}

variable "sg-name-pub" {
  type    = "string"
  default = "public"
}

variable "sg-name-pri" {
  type    = "string"
  default = "private-servers"
}

variable "ips" {
  type    = "string"
  default = "71.113.186.65/32,74.68.128.137/32"
}

#TAGS
variable "template" {
  type    = "string"
  default = "sandbox"
}

variable "created-on" {
  type    = "string"
  default = "May 30th 2020"
}