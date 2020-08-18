## TAGS

variable "name" {
  type        = "string"
  default = ""
}

variable "environment" {
  type        = "string"
  default     = ""
}

variable "purpose" {
  type        = "string"
  default     = ""
}

variable "application" {
  type        = "string"
  default     = ""
}

variable "created-on" {
  type        = "string"
  default     = ""
}

variable "template" {
  type        = "string"
  default     = ""
}

# LOGS

variable "log-destination" {
  type    = string
  default = ""
}

variable "vpc-id" {
  type    = "string"
  default = ""
}

variable "traffic-type" {
  type    = "string"
  default = ""
}

variable "max-aggregation-interval" {
  type    = "string"
  default = ""
}

variable "role-policy-name" {
  type    = "string"
  default = ""
}

variable "role-name" {
  type    = "string"
  default = ""
}
