resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(
    {
      "Name" = format("%s", var.vpc_name)
    },
    var.vpc_tags,
  )
}

resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr" {
  count = var.vpc_secondary_cidr == null ? 0 : 1
  vpc_id     = aws_vpc.main.id
  cidr_block = var.vpc_secondary_cidr
}

resource "aws_flow_log" "vpc_flow_logs" {
  count                = var.enable_vpc_logs == true ? 1 : 0
  log_destination      = var.logs_bucket_arn
  log_destination_type = var.log_destination_type
  traffic_type         = var.traffic_type
  vpc_id               = aws_vpc.main.id
}

resource "aws_internet_gateway" "igw" {
  count  = var.enable_igw == true ? 1 : 0
  vpc_id = aws_vpc.main.id
  tags = merge(
    {
      "Name" = format("%s", var.igw_name)
    },
    var.igw_tags,
  )
}



