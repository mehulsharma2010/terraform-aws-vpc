resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(
    {
      "Name" = format("%s", "${var.name}-vpc")
    },
    var.tags,
  )
}

resource "aws_flow_log" "vpc_flow_logs" {
  count                = var.enable_vpc_logs == true ? 1 : 0
  log_destination      = var.logs_bucket_arn
  log_destination_type = var.log_destination_type
  traffic_type         = var.traffic_type
  vpc_id               = aws_vpc.main.id
}

resource "aws_internet_gateway" "igw" {
  count  = var.enable_igw_publicRouteTable_PublicSubnets_resource == true ? 1 : 0
  vpc_id = aws_vpc.main.id
  tags = merge(
    {
      "Name" = format("%s-igw", var.name)
    },
    var.tags,
  )
}

module "publicRouteTable" {
  count      = var.enable_igw_publicRouteTable_PublicSubnets_resource == true ? 1 : 0
  source     = "OT-CLOUD-KIT/route-table/aws"
  version    = "0.0.1"
  cidr       = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw[count.index].id
  name       = format("%s-pub", var.name)
  vpc_id     = aws_vpc.main.id
  tags       = var.tags
}

module "PublicSubnets" {
  count              = var.enable_igw_publicRouteTable_PublicSubnets_resource == true ? 1 : 0
  source             = "OT-CLOUD-KIT/subnet/aws"
  version            = "0.0.1"
  availability_zones = var.avaialability_zones
  name               = format("%s-pub", var.name)
  route_table_id     = module.publicRouteTable[count.index].id
  subnets_cidr       = var.public_subnets_cidr
  vpc_id             = aws_vpc.main.id
  tags               = var.tags
}

module "nat-gateway" {
  count              = var.enable_nat_privateRouteTable_PrivateSubnets_resource == true ? 1 : 0
  source             = "OT-CLOUD-KIT/nat-gateway/aws"
  version            = "0.0.1"
  subnets_for_nat_gw = module.PublicSubnets[count.index].ids
  vpc_name           = var.name
  tags               = var.tags
}

module "privateRouteTable" {
  count      = var.enable_nat_privateRouteTable_PrivateSubnets_resource == true ? 1 : 0
  source     = "OT-CLOUD-KIT/route-table/aws"
  version    = "0.0.1"
  cidr       = "0.0.0.0/0"
  gateway_id = module.nat-gateway[count.index].ngw_id
  name       = format("%s-pvt", var.name)
  vpc_id     = aws_vpc.main.id
  tags       = var.tags
}

module "PrivateSubnets" {
  count              = var.enable_nat_privateRouteTable_PrivateSubnets_resource == true ? 1 : 0
  source             = "OT-CLOUD-KIT/subnet/aws"
  version            = "0.0.1"
  availability_zones = var.avaialability_zones
  name               = format("%s-pvt", var.name)
  route_table_id     = module.privateRouteTable[count.index].id
  subnets_cidr       = var.private_subnets_cidr
  vpc_id             = aws_vpc.main.id
  tags               = var.tags
}

module "public_web_security_group" {
  count               = var.enable_public_web_security_group_resource == true ? 1 : 0
  source              = "OT-CLOUD-KIT/security-groups/aws"
  version             = "1.0.0"
  enable_whitelist_ip = true
  name_sg             = var.public_web_sg_name
  vpc_id              = aws_vpc.main.id
  ingress_rule = {
    rules = {
      rule_list = [
        {
          description  = "Rule for port 80"
          from_port    = 80
          to_port      = 80
          protocol     = "tcp"
          cidr         = ["0.0.0.0/0"]
          source_SG_ID = []
        },
        {
          description  = "Rule for port 443"
          from_port    = 443
          to_port      = 443
          protocol     = "tcp"
          cidr         = ["0.0.0.0/0"]
          source_SG_ID = []
        }
      ]
    }
  }
}

module "pub_alb" {
  count                      = var.enable_pub_alb_resource == true ? 1 : 0
  source                     = "git::https://github.com/OT-CLOUD-KIT/terraform-aws-alb.git?ref=output_arn"
  alb_name                   = format("%s-pub-alb", var.name)
  internal                   = false
  logs_bucket                = var.logs_bucket
  security_groups_id         = [module.public_web_security_group[count.index].sg_id]
  subnets_id                 = module.PublicSubnets[count.index].ids
  tags                       = var.tags
  enable_logging             = var.enable_alb_logging
  enable_deletion_protection = var.enable_deletion_protection
  alb_certificate_arn        = var.alb_certificate_arn
}

resource "aws_route53_zone" "private_hosted_zone" {
  count = var.enable_aws_route53_zone_resource == true ? 1 : 0
  name  = var.pvt_zone_name
  vpc {
    vpc_id = aws_vpc.main.id
  }
}

