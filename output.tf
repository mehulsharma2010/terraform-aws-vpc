output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.*.id[0]
}

output "vpc_arn" {
  description = "The arn of the VPC"
  value       = aws_vpc.main.*.arn[0]
}

output "igw_id" {
  description = "The ID of the VPC"
  value       = aws_internet_gateway.igw.*.id[0]
}


