variable "az" {
  type    = "string"
  default = ""
}

variable "size" {
  type    = "list"
  default = []
}

variable "name" {
  type    = "list"
  default = []
}

variable "type" {
  type    = "string"
  default = ""
}

variable "encrypted" {
  type    = "string"
  default = ""
}

variable "iops" {
  type    = "string"
  default = ""
}

variable "snapshot-id" {
  type    = "string"
  default = ""
}

variable "kms-id" {
  type    = "string"
  default = ""
}

variable "template" {
  type    = "string"
  default = ""
}

variable "purpose" {
  type    = "string"
  default = ""
}

variable "application" {
  type    = "string"
  default = ""
}

variable "created-on" {
  type    = "string"
  default = ""
}

variable "environment" {
  type    = "string"
  default = ""
}
