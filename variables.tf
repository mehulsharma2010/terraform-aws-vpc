variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_secondary_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = null
}

variable "vpc_name" {
  description = "Name of the VPC to be created"
  type        = string
  default     = "vpc"
}

variable "vpc_tags" {
  description = "Additional tags for the VPC"
  type        = map(string)
  default     = {}
}

variable "igw_tags" {
  description = "Additional tags for the VPC"
  type        = map(string)
  default     = {}
}

variable "logs_bucket_arn" {
  description = "ARN of bucket where we would be storing vpc our logs"
  default = " "
}

variable "enable_dns_support" {
  type    = bool
  default = true
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "instance_tenancy" {
  type    = string
  default = "default"
}

variable "log_destination_type" {
  type    = string
  default = "s3"
}

variable "traffic_type" {
  type    = string
  default = "ALL"
}

variable "enable_vpc_logs" {
  type    = bool
  default = false
}

variable "enable_igw" {
  type    = bool
  default = true
}

variable "igw_name" {
  type        = string
  description = "Internet Gateway name"
}
