# output "subnet_id" {
#   value = aws_subnet.subnet_main.id
# }

# output "subnet_cidr" {
#   value = aws_subnet.subnet_main.cidr_block[count.index]
# }

output "subnet_id" {
value={for index,subnet in aws_subnet.subnet_main : "${var.name}-${index+1}" => subnet.id}
}

# # output "subnet_cidr" {
# #   value = tomap({ for index, subnet in module.subnet_main : "${var.name}-${index + 1}" => subnet.subnet_cidr })
# # }

# output "subnet_id122222" {
#   value = { for index, subnet in aws_subnet.subnet_main : "${var.name}-${index + 1}" => subnet.subnet_id11111}
# }