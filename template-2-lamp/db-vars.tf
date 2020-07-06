variable "engine" {
  type    = "string"
  default = "mysql"
}

variable "storage" {
  type    = "string"
  default = "30"
}

variable "storage-type" {
  type    = "string"
  default = "gp2"
}

variable "engine-version" {
  type    = "string"
  default = "5.7.22"
}

variable "instance-class" {
  type    = "string"
  default = "db.t2.micro"
}

variable "rds-name" {
  type    = "string"
  default = "personal-website"
}

variable "publicly-accessible" {
  type    = "string"
  default = "false"
}

variable "subnet-group-name" {
  type    = "string"
  default = "subnet-group"
}

variable "db-port" {
  type    = "string"
  default = "3306"
}

variable "route53-zone-id" {
  type    = "string"
  default = "Z1AJ8ZWN9ZA2LW"
}

variable "snapshot-identifier" {
  type    = "string"
  default = "personal-website-dev-snapshot"
}

variable "final-snapshot" {
  type    = "string"
  default = "terraform-snapshot-personal-website-prod"
}

variable "skip-final-snapshot" {
  type    = "string"
  default = "true"
}

variable "recordName" {
  type    = "string"
  default = "proddbconnection"
}