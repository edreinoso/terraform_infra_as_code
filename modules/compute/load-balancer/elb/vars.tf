variable "elb-name" {
  type    = "string"
  default = ""

  # type    = "list"
  # default = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "lb_tags" {
  description = "A map of tags to add to load balancer"
  type        = map(string)
  default     = {}
}

variable "elb-type" {
  type    = "string"
  default = ""
}

variable "internal-elb" {
  type    = "string"
  default = ""
}

variable "subnet-ids" {
  # type    = "string"
  # default = ""
  type    = "list"
  default = []
}

variable "security-group" {
  type    = "list"
  default = []
}

variable "vpc-id" {
  type    = "string"
  default = ""
}

variable "bucket-name" {
  type    = "string"
  default = ""
}

variable "environment" {
  type    = "string"
  default = ""
}

variable "template" {
  type = "string"
  default = ""
}

variable "application" {
  type = "string"
  default = ""  
}

variable "purpose" {
  type = "string"
  default = ""
}

variable "created-on" {
  type = "string"
  default = ""
}