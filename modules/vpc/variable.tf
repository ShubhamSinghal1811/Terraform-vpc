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

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
}
