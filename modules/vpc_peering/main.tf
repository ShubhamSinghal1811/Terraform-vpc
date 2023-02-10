resource "aws_vpc_peering_connection" "foo" {
  peer_vpc_id   = var.peer_vpc_id
  vpc_id        = var.vpc_id
  peer_owner_id = var.peer_owner_id
  auto_accept=var.auto_accept
  peer_region   = var.peer_region

}