variable "AWS_REGIONS" {
  default = "us-east-1"
}

variable "template" {
  type    = "string"
  default = "template-1-autoscaling"
}

variable "created-on" {
  type    = "string"
  default = "July_28_2020"
}

variable "application" {
  type    = "string"
  default = "aws_infra_terraform"
}

variable "purpose" {
  type    = "string"
  default = "testing autoscaling module"
}
