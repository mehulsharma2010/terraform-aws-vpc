resource "aws_subnet" "protected_subnets" {
  count                   = length(var.protected_subnets_cidr)
  vpc_id                  = var.vpc_id
  cidr_block              = var.protected_subnets_cidr[count.index]
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false
  tags = merge(
    var.tags,
    {
      "Name" = format("%s-%d", var.protected_subnet_name, count.index + 1)
    }
  )
}

resource "aws_route_table" "protected_rt" {
  vpc_id = var.vpc_id

  tags = merge(
    var.tags,
    {
      "Name" = var.protected_rt_name
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
      "Name" = format("%s-Nacl", var.protected_subnet_name)
    }
  )
}
resource "aws_network_acl_rule" "inbound_rules" {
  for_each       = var.protected_nacl_inbound_rules
  network_acl_id = aws_network_acl.protected_subnet_acl.id
  rule_number    = each.value.rule_number
  egress         = false
  protocol       = each.value.protocol
  rule_action    = each.value.action
  cidr_block     = each.value.cidr_block

  # Set from_port and to_port based on the protocol
  from_port      = each.value.protocol != "-1" ? lookup(each.value, "from_port", null) : null
  to_port        = each.value.protocol != "-1" ? lookup(each.value, "to_port", null) : null
}

resource "aws_network_acl_rule" "outbound_rules" {
  for_each       = var.protected_nacl_outbound_rules
  network_acl_id = aws_network_acl.protected_subnet_acl.id
  rule_number    = each.value.rule_number
  egress         = true
  protocol       = each.value.protocol
  rule_action    = each.value.action
  cidr_block     = each.value.cidr_block

  # Set from_port and to_port based on the protocol
  from_port      = lookup(each.value, "from_port", null)
  to_port        = lookup(each.value, "to_port", null)
}
