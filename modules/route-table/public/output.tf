output "rid" {
value={for index,route_table_id in aws_route_table.route_table_public : "${var.name}-rt-${index+1}" => route_table_id.id}
}