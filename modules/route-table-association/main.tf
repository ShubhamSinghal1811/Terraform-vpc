resource "aws_route_table_association" "route_table_association" {
  for_each = var.subnet_ids
  route_table_id = var.route_table_id
  subnet_id      = each.value
}
