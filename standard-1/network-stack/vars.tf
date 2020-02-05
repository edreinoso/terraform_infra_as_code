variable "AWS_REGIONS" {
  default = "us-east-1"
}

#Environment
variable "environment" {
  type = "map"

  default = {
    dev = "dev"
  }
}

variable "template" {
  type = "string"
  default = "standard-1"
}

#VPC Components
variable "vpc-name" {
  type = "map"

  default = {
    dev = "sample-vpc-dev"
  }
}

variable "vpc-cidr" {
  type = "map"

  default = {
    dev = "10.0.1.0/24"
  }
}

variable "vpc-dns-hostname" {
  type    = "string"
  default = true
}

variable "vpc-dns-support" {
  type    = "string"
  default = true
}

#Internet gateway
variable "igw-name" {
  type    = "string"
  default = "sample-igw"
}

#Subnet component
#Public subnets
variable "public-type" {
  type    = "string"
  default = "public"
}

variable "az1PublicSubnetCidr" {
  type = "map"

  default = {
    dev = "10.0.1.0/27"
  }
}

variable "az1PublicSubnetNames" {
  type = "map"

  default = {
    dev = "public-subnet-01"
  }
}

variable "az2PublicSubnetCidr" {
  type = "map"

  default = {
    dev = "10.0.1.32/27"
  }
}

variable "az2PublicSubnetNames" {
  type = "map"

  default = {
    dev = "public-subnet-02"
  }
}

variable "publicSubnet" {
  type    = "string"
  default = "public"
}

#Private subnets
variable "private-type" {
  type    = "string"
  default = "private"
}
variable "az1PrivateSubnetCidr" {
  type = "map"

  default = {
    dev = "10.0.1.64/27,10.0.1.96/27,10.0.1.128/27"
  }
}

variable "az1PrivateSubnetNames" {
  type = "map"

  default = {
    dev = "private-web-subnet-01,private-app-subnet-01,private-db-subnet-01"
  }
}

variable "az2PrivateSubnetCidr" {
  type = "map"

  default = {
    dev = "10.0.1.160/27,10.0.1.192/27,10.0.1.224/27"
  }
}

variable "az2PrivateSubnetNames" {
  type = "map"

  default = {
    dev = "private-web-subnet-02,private-app-subnet-02,private-db-subnet-02"
  }
}

variable "privateSubnet" {
  type    = "string"
  default = "private"
}

variable "main-subnet" {
  type    = "string"
  default = "main-subnet"
}

variable "ha-subnet" {
  type    = "string"
  default = "ha-subnet"
}

# Route Tables
variable "publicRouteTable" {
  type    = "string"
  default = "public-route-table"
}

variable "privateRouteTable" {
  type    = "string"
  default = "private-route-table"
}

variable "destinationRoute" {
  type    = "string"
  default = "0.0.0.0/0"
}

# Security Group
variable "sg-name-pub" {
  type    = "string"
  default = "pub"
}

variable "sg-name-pri" {
  type    = "string"
  default = "pri"
}
