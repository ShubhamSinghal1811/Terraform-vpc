
variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
}
variable "subnet_ids" {
  type        = list(string)
  description = "An ID for subnet of the environment"
}
variable "default_network_acl_id" {
  type        = string
  description = "An ID for VPC of the environment"
}