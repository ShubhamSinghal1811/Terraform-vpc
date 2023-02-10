output "subnet_id" {
  value = { for index, subnet in module.subnet_main : "${index}" => subnet.subnet_id }
}
output "route_table_id_public" {
  value = { for subnet_type, route_table_id in module.route_table_public : "${subnet_type}" => route_table_id.rid }

}
output "route_table_id_private" {
  value = { for subnet_type, route_table_id in module.route_table_private : "${subnet_type}" => route_table_id.rid }
}

output "vpc" {
  value = { for index, value in module.vpc_main : "${index}" => value }
}


