

resource "aws_vpc_endpoint" "vpc_endpoint" {
  service_name        = var.service_name
  vpc_id              = var.vpc_id
  vpc_endpoint_type   = "Interface"
  security_group_ids  = var.security_group_ids
  subnet_ids          = var.subnet_ids
  # private_dns_enabled = var.private_dns_enabled
  tags                = var.tags
}