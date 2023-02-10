resource "aws_subnet" "subnet_main" {
  count                   = length(var.subnet_details)
  cidr_block              = lookup(var.subnet_details[count.index], "cidr_block", "undefined")
  vpc_id                  = var.vpc_id
  availability_zone       = "${var.region}${lookup(var.subnet_details[count.index], "availability_zone", "undefined")}"
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = merge(var.tags, tomap({
    "Name" : "${var.project_name_prefix}-${var.name}-${count.index + 1}"
  }))
}