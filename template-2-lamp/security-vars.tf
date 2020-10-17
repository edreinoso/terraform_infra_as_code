### SECURITY GROUPS ###
  variable "protocol" {
    description = "specify which protocol a certain security group is from"
    type        = "map"
    default     = {
      "nat" = "ssh"
      "elb" = "http"
      "web" = "ssh-http"
      "app" = "ssh-http"
      "db"  = "mysql"
    }
  }

  variable "sg-name-pub" {
    type    = "string"
    default = ""
  }

  variable "sg-name-pri" {
    type    = "string"
    default = ""
  }
  
  variable "sg-name-db" {
    type    = "string"
    default = ""
  }

  variable "sg-name-elb" {
    type    = "string"
    default = ""
  }

  variable "ips" {
    type    = "string"
    default = "" # your IP addresses that you want to provide access to your infrastructure
  }
