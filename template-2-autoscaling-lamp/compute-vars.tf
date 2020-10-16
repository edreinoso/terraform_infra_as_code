## AUTOSCALING ##

  variable "launch-configuration-name" {
    type    = "string"
    default = ""
  }

  variable "autoscaling-name" {
    type    = "string"
    default = ""
  }

  # this ami is going to be the one of the web server
  # base Amazon Linux AMI is given below
  variable "ami" {
    type    = "string"
    default = ""
  }

  variable "instance-type" {
    type    = "string"
    default = ""
  }

  variable "health-check" {
    type    = "string"
    default = ""
  }

  variable "enabled_metrics" {
    type = "list"
    default = []
  }

  variable "key-name-pub" {
    type    = "string"
    default = ""
  }

## ELB ##

  variable "elb-name" {
    type    = "string"
    default = ""
  }

  variable "elb-type" {
    type    = "string"
    default = ""
  }

  variable "internal-elb" {
    type    = "string"
    default = ""
  }

  variable "elb-tg-name" {
    type = "string"
    default = ""
  }

  variable "tg-port" {
    type    = "string"
    default = ""
  }

  variable "listener-protocol" {
    type    = "string"
    default = ""
  }

  variable "certificate" {
    type    = "string"
    default = ""
  }
  
  variable "ssl-policy" {
    type    = "string"
    default = ""
  }

  variable "tg-protocol" {
    type    = "string"
    default = ""
  }

  variable "tg-target-type" {
    type    = "string"
    default = ""
  }

  variable "tg-deregister" {
    type = ""

    # monitor for change
    default = ""
  }

## S3 ## 

  variable "bucket-name" {
    type    = "string"
    default = ""
  }

  variable "acl" {
    type    = "string"
    default = ""
  }

  variable "destroy" {
    type    = "string"
    default = ""
  }

  variable "account-id" {
    type    = "string"
    default = "" # your account ID
  }


## NAT ##

  variable "instance-type" {
    type    = "string"
    default = ""
  }

  variable "public-ip-association-true" {
    type    = "string"
    default = ""
  }

  variable "public-ip-association-false" {
    type    = "string"
    default = ""
  }

  variable "sourceCheck-disable" {
    type = "string"
    default = ""
  }

  variable "key-name-pub" {
    type    = "string"
    default = ""
  }

  variable "key-name-pri" {
    type    = "string"
    default = ""
  }