resource "aws_route_table" "route_table_private" {
  count  = var.nat_gateway ? 1 : 0
  vpc_id = var.vpc_id
  route {
    cidr_block     = var.cidr_block
    nat_gateway_id = var.nat_gateway_id
  }
  lifecycle {
    ignore_changes = [
      vpc_id,
      route,
    ]
  }
  tags = merge(var.tags, tomap({
    "Name" : "${var.project_name_prefix}-${var.name}"
  }))
}


