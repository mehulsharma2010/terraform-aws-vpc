variable "vpc_name" {
  type    = string
  default = "test-non-prod"
}

variable "cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "enable_vpc_logs" {
  type    = bool
  default = false
}

variable "public_subnets_cidr" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "pvt_subnet_name" {
  type    = list(string)
  default = ["test-non-prod-pvt-app-1", "test-non-prod-pvt-app-2","test-non-prod-pvt-mgmt-1", "test-non-prod-pvt-mgmt-2", "test-non-prod-pvt-db-1","test-non-prod-pvt-db-2"]
}

variable "private_subnets_cidr" {
  type    = list(string)
  default = ["10.0.16.0/20", "10.0.32.0/20", "10.0.48.0/24", "10.0.49.0/24", "10.0.50.0/24", "10.0.51.0/24"]
}

variable "pub_subnet_name" {
  type    = list(string)
  default = ["test-non-prod-pub-subnet-1", "test-non-prod-pub-subnet-2"]
}


variable "pub_rt_name" {
  type    = string
  default = "test-non-prod-pub"
}


variable "alb_name" {
  type    = string
  default = ""
}

variable "igw_name" {
  type    = string
  default = "test-non-prod-igw"
}

variable "nat_name" {
  type    = string
  default = "test-non-prod-nat"
}
variable "pvt_rt_ame" {
  type    = string
  default = "test-non-prod-pvt"
}
variable "pvt_zone_name" {
  type    = string
  default = ""
}



variable "avaialability_zones" {
  type    = list(string)
  default = ["ap-south-1a", "ap-south-1b"]
}

variable "logs_bucket" {
  type    = string
  default = ""
}

variable "logs_bucket_arn" {
  type    = string
  default = ""
}

variable "tags" {
  type    = map(string)
  default = {
    "Owner"                          = "devops"
    "Environment"                    = "non-prod"
  }
  
}
variable "subnet_tags" {
  type    = map(string)
  default = {
    "subnet"                          = "private"
    "app"                    = "eks"
  }
  
}


variable "public_web_sg_name" {
  type    = string
  default = "ns-web-sg"
}

variable "alb_certificate_arn" {
  type    = string
  default = ""
}

variable "enable_igw_publicRouteTable_PublicSubnets_resource" {
  type    = bool
  default = false
}

variable "enable_nat_privateRouteTable_PrivateSubnets_resource" {
  type    = bool
  default = false
}

variable "enable_public_web_security_group_resource" {
  type    = bool
  default = false
}

variable "enable_pub_alb_resource" {
  type    = bool
  default = false
}

variable "enable_aws_route53_zone_resource" {
  type    = bool
  default = false
}
