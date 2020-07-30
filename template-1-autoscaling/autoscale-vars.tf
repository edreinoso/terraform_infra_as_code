variable "launch-configuration-name" {
  type    = "string"
  default = "lc_example"
}

variable "autoscaling-name" {
  type    = "string"
  default = "asg_example"
}

variable "ami" {
  type    = "string"
  default = "ami-08f3d892de259504d"
}

variable "instance-type" {
  type    = "string"
  default = "t2.micro"
}

variable "health-check" {
  type    = "string"
  default = "EC2"
}

# variable "role" {
#   type    = "string"
#   default = ""
# }

variable "enabled_metrics" {
  type = "list"
  default = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupTotalInstances",
  ]
}

variable "key-name-pub" {
  type    = "string"
  default = "base-template"
}