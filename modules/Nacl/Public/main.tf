resource "aws_network_acl" "main" {
  vpc_id = var.vpc_id
  tags   = var.tags
  subnet_ids =  var.subnet_ids 
 

}