## EC2 ##
  #Web | NAT
  variable "web-server-ami" {
    type    = "string"
    default = ""
  }

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

  variable "sourceCheck-enable" {
    type = "string"
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

  variable "tg-protocol" {
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

  variable "tg-target-type" {
    type    = "string"
    default = ""
  }

  variable "tg-deregister" {
    type = ""
    # time to deregister target groups
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
