resource "aws_security_group" "allow_tls" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id
  tags = var.tags
}