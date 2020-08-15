variable "AWS_REGIONS" {
  default = "us-east-1"
}

variable "template" {
  type    = "string"
  default = "terraform_infrastructure_as_code"
}

variable "created-on" {
  type    = "string"
  default = "August_14_2020"
}

variable "application" {
  type    = "string"
  default = "template-1-autoscaling"
}

variable "purpose" {
  type    = "string"
  default = "testing different autoscaling modules"
}
