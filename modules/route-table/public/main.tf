resource "aws_route_table" "route_table_public" {
  count      = var.is_public ? 1 : 0
  vpc_id = var.vpc_id
  route {
    cidr_block = var.cidr_block
    gateway_id = var.gateway_id
  }
  tags = merge(var.tags, tomap({
    "Name" : "${var.project_name_prefix}-${var.name}"
  }))
}