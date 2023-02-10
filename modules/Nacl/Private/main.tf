resource "aws_default_network_acl" "main" {
  default_network_acl_id = var.default_network_acl_id
  tags   = var.tags
  subnet_ids = var.subnet_ids 
  

}