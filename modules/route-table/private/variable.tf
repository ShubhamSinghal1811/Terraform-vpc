variable "cidr_block" {
  type        = string
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
}
variable "vpc_id" {
  type        = string
  description = "An ID for VPC of the environment"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
}

variable "nat_gateway" {
  type        = bool
  description = "Boolean value for the Nat Gateway to enable"
}

variable "nat_gateway_id" {
  type        = string
  description = "An ID for NAT Gateway of the environment"
}

variable "project_name_prefix" {
  type        = string
  description = "A project name prefix for Route Table"
}
variable "name" {
  type        = string
  description = "An Name for Route Table of the environment"
}



