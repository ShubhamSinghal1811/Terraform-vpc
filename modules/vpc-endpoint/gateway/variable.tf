variable "vpc_id" {
    type=string
    description="vpc_id"
}

variable "service_name" {
    type=string
    description = "service_name"
}

variable "route_table_ids" {
  type        = list(string)
  description = "A list of Route Table IDs"
}
variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
}