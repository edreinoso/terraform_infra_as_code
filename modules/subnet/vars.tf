variable "vpc-id" {
  type    = "string"
  default = ""
}

variable "subnet-cidr" {
  type    = "list"
  default = []
}

variable "subnet-name" {
  type    = "list"
  default = []
}

variable "availability_zone" {
  type    = "string"
  default = ""
}

variable "visibility" {
  type    = "string"
  default = "private"
}

variable "subnet-availability" {
  type    = "string"
  default = ""
}

variable "type" {
  type    = "string"
  default = ""
}

variable "template" {
  type = "string"
  default = ""
}