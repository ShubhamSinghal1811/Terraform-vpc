output "vpc_id" {
  value = aws_vpc.vpc_main.id
}
output "nacl_id"{
  value = aws_vpc.vpc_main.default_network_acl_id
}

output "default_rid" {
  value = aws_vpc.vpc_main.default_route_table_id
}

output "main_rid" {
  value = aws_vpc.vpc_main.main_route_table_id
}

