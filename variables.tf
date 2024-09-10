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


variable "protected_subnets_cidr" {
  description = "CIDR blocks for protected subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
}
variable "protected_nacl_inbound_rules" {
  type = map(object({
    rule_number = number
    protocol    = string
    action      = string
    cidr_block  = string
    from_port   = optional(number)  
    to_port     = optional(number)
  }))
}

variable "protected_nacl_outbound_rules" {
  type = map(object({
    rule_number = number
    protocol    = string
    action      = string
    cidr_block  = string
    from_port   = optional(number)  
    to_port     = optional(number)
  }))
}


variable "protected_rt_name" {
  type = string
}
variable "protected_subnet_name" {
  type = string
}