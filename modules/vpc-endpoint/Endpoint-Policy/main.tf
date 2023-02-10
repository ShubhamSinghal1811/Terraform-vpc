resource "aws_vpc_endpoint_policy" "example" {
  vpc_endpoint_id = var.vpc_endpoint_id
  policy = var.policy
}