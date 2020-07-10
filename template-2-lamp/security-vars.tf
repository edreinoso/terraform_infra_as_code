# Security Group
variable "sg-name-pub" {
  type    = "string"
  default = "pub"
}

variable "sg-name-pri" {
  type    = "string"
  default = "pri"
}

variable "sg-name-db-pri" {
  type    = "string"
  default = "database-sg-private"
}

variable "ips" {
  type    = "string"
  default = "" # your IP addresses that you want to provide access to your infrastructure
}
