resource "aws_vpc_endpoint" "vpc_endpoint" {
  service_name      = var.service_name
  vpc_id            = var.vpc_id
  vpc_endpoint_type = "Gateway"
  route_table_ids   = var.route_table_ids
  tags              = var.tags
}