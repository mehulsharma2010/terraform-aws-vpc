output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "pub_route_table_id" {
  description = "Public route table ID"
  value = module.publicRouteTable.id
}

output "pvt_route_table_id" {
  description = "Private Route table ID" 
  value = module.privateRouteTable.id
}

output "pub_alb_dns" {
  value = module.pub_alb.dns_name
}

output "pvt_hosted_zone_id" {
  description = "hosted zone id"
  value       = aws_route53_zone.private_hosted_zone.zone_id
}

output "pvt_subnet_ids" {
  value = module.PrivateSubnets.ids
}

output "public_subnet_ids" {
  value = module.PublicSubnets.ids
}

output "private_subnet_ids" {
  value = module.PrivateSubnets.ids
}

output "web_sg_id" {
  value = module.public_web_security_group.sg_id
}
