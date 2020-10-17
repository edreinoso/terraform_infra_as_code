## RDS ##

  variable "engine" {
    type    = "string"
    default = ""
  }

  variable "storage" {
    type    = "string"
    default = ""
  }

  variable "storage-type" {
    type    = "string"
    default = ""
  }

  variable "engine-version" {
    type    = "string"
    default = ""
  }

  variable "instance-class" {
    type    = "string"
    default = ""
  }

  variable "rds-name" {
    type    = "string"
    default = ""
  }

  variable "username" {
    type    = "string"
    default = ""
  }

  variable "password" {
    type    = "string"
    default = ""
  }

  variable "db-name" {
    type    = "string"
    default = ""
  }

  variable "publicly-accessible" {
    type    = "string"
    default = ""
  }

  variable "db-port" {
    type    = "string"
    default = ""
  }

  variable "skip-final-snapshot" {
    type    = "string"
    default = ""
  }

  variable "snapshot-identifier" {
    type    = "string"
    default = ""
  }

  variable "final-snapshot" {
    type    = "string"
    default = ""
  }

## SUBNET GROUP ##
  
  variable "subnet-group-name" {
    type    = "string"
    default = ""
  }
