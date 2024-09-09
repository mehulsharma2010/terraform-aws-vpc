output "protected_subnet_ids" {
  description = "List of Protected Subnet IDs"
  value       = aws_subnet.protected_subnets[*].id
}