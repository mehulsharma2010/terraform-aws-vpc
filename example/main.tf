provider "aws" {
  region                  = "ap-south-1"
}

module "network_skeleton" {
  source                                               = "../"
  vpc_name                                             = var.vpc_name
  cidr_block                                           = "10.0.0.0/16"
  enable_dns_hostnames                                 = true
  enable_vpc_logs                                      = false
  pvt_zone_name                                        = "test.non-prod.net"
  public_subnets_cidr                                  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets_cidr                                 = ["10.0.16.0/20", "10.0.32.0/20", "10.0.48.0/24", "10.0.49.0/24", "10.0.50.0/24", "10.0.51.0/24"]
  pvt_rt_ame                                           = var.pvt_rt_ame
  pvt_subnet_name                                      = var.pvt_subnet_name
  pub_subnet_name                                      = var.pub_subnet_name
  pub_rt_name                                          = var.pub_rt_name
  igw_name                                             = var.igw_name
  nat_name                                             = var.nat_name
  avaialability_zones                                  = ["ap-south-1a", "ap-south-1b"]
  logs_bucket                                          = ""
  logs_bucket_arn                                      = ""
  tags                                                 = {"Environment" = "non-prod", "Owner" = "devops"}
  subnet_tags                                          = {"Subnet" = "private", "App" = "EKS"}
  public_web_sg_name                                   = "ns-web-sg"
  alb_certificate_arn                                  = ""
  alb_name                                             = var.alb_name
  enable_igw_publicRouteTable_PublicSubnets_resource   = true
  enable_nat_privateRouteTable_PrivateSubnets_resource = true
  enable_public_web_security_group_resource            = false
  enable_pub_alb_resource                              = false
  enable_aws_route53_zone_resource                     = false
}