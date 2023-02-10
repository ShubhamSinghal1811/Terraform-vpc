variable "vpc_id" {
  type=string
}

variable "name" {
  type=string
}

variable "description" {
  type=string
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
}