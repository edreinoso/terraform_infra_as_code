variable "ami" {
  type    = "string"
  default = ""
}

variable "instance-type" {
  type    = "string"
  default = ""
}

variable "ec2-name" {
  type    = "string"
  default = ""
}

variable "template" {
  type    = "string"
  default = ""
}

variable "subnet-ids" {
  type    = "string"
  default = ""
}

variable "user-data" {
  type    = "string"
  default = ""
}

variable "key-name" {
  type    = "string"
  default = ""
}

variable "public-ip" {
  type    = "string"
  default = ""
}

variable "sourceCheck" {
  type    = "string"
  default = ""
}

variable "security-group-ids" {
  type    = "list"
  default = []
}

variable "instance-role" {
  type    = "string"
  default = ""
}

variable "volume-size" {
  type    = "string"
  default = ""
}
