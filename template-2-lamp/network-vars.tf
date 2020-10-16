## VPC ##
  variable "vpc-name" {
    type = "map"

    default = {
      dev = ""
    }
  }

  variable "vpc-cidr" {
    type = "map"

    default = {
      dev = ""
      # dev = "172.168.0.0/24"
    }
  }

  variable "vpc-dns-hostname" {
    type    = "string"
    default = ""
  }

  variable "vpc-dns-support" {
    type    = "string"
    default = ""
  }

## FLOW LOGS ##
  
  variable "flow-logs-name" {
    type    = "string"
    default = ""
  }

  variable "log-destination" {
    type    = "string"
    default = "" #for now this would be example
  }

  variable "traffic-type" {
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

  variable "max-aggregation-interval" {
    type    = "string"
    default = ""
  }

## SUBNET ##
  
  ## PUBLIC subnet AZ 1 ##

    variable "az1PublicSubnetCidr" {
      type = "map"

      default = {
        dev = ""
        # dev = "172.168.0.0/27"
      }
    }

    variable "az1PublicSubnetNames" {
      type = "map"

      default = {
        dev = ""
        # dev = "public-subnet-01"
      }
    }

  ## PUBLIC subnet AZ 2 ##

    variable "az2PublicSubnetCidr" {
      type = "map"

      default = {
        dev = ""
        # dev = "172.168.0.32/27"
      }
    }

    variable "az2PublicSubnetNames" {
      type = "map"

      default = {
        dev = ""
        # dev = "public-subnet-02"
      }
    }
  
  ## PRIVATE subnet AZ 1 ##
  
    variable "az1PrivateSubnetCidr" {
      type = "map"

      default = {
        dev = ""
        # dev = "172.168.0.64/27,172.168.0.96/27,172.168.0.128/27"
      }
    }

    variable "az1PrivateSubnetNames" {
      type = "map"

      default = {
        dev = ""
        # dev = "private-web-subnet-01,private-app-subnet-01,private-db-subnet-01"
      }
    }

  ## PRIVATE subnet AZ 2 ##
    
    variable "az2PrivateSubnetCidr" {
      type = "map"

      default = {
        dev = ""
        # dev = "172.168.0.160/27,172.168.0.192/27,172.168.0.224/27"
      }
    }

    variable "az2PrivateSubnetNames" {
      type = "map"

      default = {
        dev = ""
        # dev = "private-web-subnet-02,private-app-subnet-02,private-db-subnet-02"
      }
    }

## INTERNET GATEWAY ##
  
  variable "igw-name" {
    type    = "string"
    default = "sample-igw"
  }

## ROUTE TABLES ##
  
  variable "publicRouteTable" {
    type    = "string"
    default = ""
  }

  variable "privateRouteTable" {
    type    = "string"
    default = ""
  }

  variable "destinationRoute" {
    type    = "string"
    default = ""
    # default = "0.0.0.0/0"
  }
