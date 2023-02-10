variable "vpc_id" {
    type=string
    description="vpc_id"
}

variable "service_name" {
    type=string
    description = "service_name"
}
variable "security_group_ids" {
  type        = list(string)
  description = "A list of Security group IDs"
}
variable "subnet_ids" {
  type        = list(string)
  description = "A list of Subnet IDs"
}
variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
}
# variable "private_dns_enabled" {
#   type        = bool
#   default     = true
#   description = "A boolean flag to enable/disable private DNS for VPC Epoint Interface"
# }