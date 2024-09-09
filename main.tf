resource "aws_subnet" "protected_subnets" {
  count                   = length(var.protected_subnets_cidr)
  vpc_id                  = var.vpc_id
  cidr_block              = var.protected_subnets_cidr[count.index]
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false
  tags = merge(
    var.tags,
    {
      "Name" = format("%s-protected-subnet-%d", var.vpc_name, count.index + 1)
    }
  )
}

resource "aws_route_table" "protected_rt" {
  vpc_id = var.vpc_id

  tags = merge(
    var.tags,
    {
      "Name" = format("%s-protected-rt", var.vpc_name)
    }
  )
}

resource "aws_route_table_association" "protected_subnet_association" {
  count          = length(aws_subnet.protected_subnets)
  subnet_id      = aws_subnet.protected_subnets[count.index].id
  route_table_id = aws_route_table.protected_rt.id
}

resource "aws_network_acl" "protected_subnet_acl" {
  vpc_id     = var.vpc_id
  subnet_ids = aws_subnet.protected_subnets[*].id

  tags = merge(
    var.tags,
    {
      "Name" = format("%s-protected-subnet-acl", var.vpc_name)
    }
  )
}

resource "aws_network_acl_rule" "inbound_rules" {
  for_each       = var.inbound_rules
  network_acl_id = aws_network_acl.protected_subnet_acl.id
  rule_number    = each.value.rule_number
  egress         = false
  protocol       = each.value.protocol
  rule_action    = each.value.action
  cidr_block     = each.value.cidr_block
}

resource "aws_network_acl_rule" "outbound_rules" {
  for_each       = var.outbound_rules
  network_acl_id = aws_network_acl.protected_subnet_acl.id
  rule_number    = each.value.rule_number
  egress         = true
  protocol       = each.value.protocol
  rule_action    = each.value.action
  cidr_block     = each.value.cidr_block
}
