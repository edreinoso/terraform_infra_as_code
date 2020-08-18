### NACLS ###
variable "egress" {
  type = "string"
  default = "true"
  # default = "true,true,true,true"
}

variable "ingress" {
  type = "string"
  default = "false" # egress false means ingress
  # default = "false,false,false" # egress false means ingress
}

variable "cidr" {
  type    = "string"
  default = "0.0.0.0/0"
  # default = "193.145.63.154/32,193.145.63.165/32,193.145.63.145/32,0.0.0.0/0"
}

variable "rule-no" {
  type    = "string"
  default = "100"
  # default = "100,200,300,400"
}

variable "protocol" {
  type = "string"
  default = "tcp"
}

variable "action" {
  type = "string"
  default = "allow"
  # default = "deny,deny,deny,allow"
}

variable "from-port" {
  type = "string"
  default = "80"
}

variable "to-port" {
  type = "string"
  default = "80"
}

### SECURITY GROUPS ###
variable "sg-name-pub" {
  type    = "string"
  default = "pub"
}

variable "sg-name-pri" {
  type    = "string"
  default = "pri"
}

variable "sg-name-elb" {
  type    = "string"
  default = "elb"
}

variable "ips" {
  type    = "string"
  default = "100.12.75.72/32" # your IP addresses that you want to provide access to your infrastructure
}
