resource "aws_security_group_rule" "example" {
  type              = var.type
  from_port         = var.from_port
  to_port           = var.to_port
  protocol          = var.protocol
  cidr_blocks       = [var.cidr_blocks]
# ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = var.security_group_id
}