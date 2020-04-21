variable "AWS_REGIONS" {
  default = "us-east-1"
}

#Environment
variable "environment" {
  type = "map"

  default = {
    dev = "dev"
  }
}

variable "template" {
  type    = "string"
  default = "standard-2"
}
