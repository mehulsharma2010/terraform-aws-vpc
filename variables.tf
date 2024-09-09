variable "enable_protected_subnet" {
  description = "Flag to determine if protected subnets should be created"
  type        = bool
  default     = false
}


variable "vpc_id" {}

variable "tags" {
  description = "A map of tags to be added to subnets"
  type        = map(string)
  default     = {}
}
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "vpc_name" {
  description = "VPC Name"
  type        = string
  default = "test"

}

variable "protected_subnets_cidr" {
  description = "CIDR blocks for protected subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
}

variable "inbound_rules" {
  type = map(object({
    rule_number = number
    protocol    = string
    cidr_block  = string
    action      = string
  }))
}

variable "outbound_rules" {
  type = map(object({
    rule_number = number
    protocol    = string
    cidr_block  = string
    action      = string
  }))
}
