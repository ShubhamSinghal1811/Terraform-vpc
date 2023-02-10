variable "cidr_block" {
  type        = string
  description = "IPV4 range for VPC Creation"
}

variable "enable_dns_support" {
  type        = bool
  description = "A boolean flag to enable/disable DNS support in the VPC"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "A boolean flag to enable/disable DNS hostnames in the VPC"
}

variable "region" {
  type        = string
  description = "region"

}

variable "tags" {
  type        = map(string)
  description = "A map to add common tags to all the resources"
}

variable "project_name_prefix" {
  type        = string
  description = "A map to add common tags to all the resources"
}


variable "subnets" {
  type = map(object({
    is_public   = bool
    vpc_index   = number
    nat_gateway = bool
    details = list(object({
      availability_zone = string
      cidr_block        = string
    }))
  }))
}

variable "sg" {
  type = map(object({
    name        = string
    description = string
  }))

}

variable "sg-rule" {
  type = map(object({


    type                = string
    from_port           = number
    to_port             = number
    protocol            = string
    cidr_block          = string
    security_group_name = string
  }))

}


variable "public-nacl-rules" {
  type = map(object({
    # network_acl_id = string
    rule_number = number
    egress      = bool
    protocol    = string
    rule_action = string
    cidr_block  = string
    from_port   = number
    to_port     = number
  }))
}

variable "private-nacl-rules" {
  type = map(object({
    # network_acl_id = string
    rule_number = number
    egress      = bool
    protocol    = string
    rule_action = string
    cidr_block  = string
    from_port   = number
    to_port     = number
  }))
}

variable "peer_vpc_id" {
  type = string
}
variable "peer_owner_id" {
  type = number
}
variable "peer_region" {
  type = string
}
variable "auto_accept" {
  type = bool
}




# variable "name" {
#   type        = string
#   description = "An Name for Route Table of the environment"
# }