module "vpc_main" {
  source               = "./modules/vpc"
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags = merge(var.tags, tomap({
    "Name" : "${var.project_name_prefix}-vpc"
  }))
}

module "subnet_main" {
  depends_on              = [module.vpc_main]
  source                  = "./modules/subnet"
  for_each                = var.subnets
  subnet_details          = each.value.details
  vpc_id                  = module.vpc_main.vpc_id
  region                  = var.region
  map_public_ip_on_launch = each.value.is_public
  name                    = each.key
  project_name_prefix     = var.project_name_prefix
  tags                    = var.tags
}

module "internet_gateway" {
  depends_on = [module.vpc_main]
  source     = "./modules/internet-gateway"
  vpc_id     = module.vpc_main.vpc_id

  tags = merge(var.tags, tomap({
    "Name" : "${var.project_name_prefix}-ig"
  }))
}

module "elastic_ip" {
  source = "./modules/elastic-ip"
  tags = merge(var.tags, tomap({
    "Name" : "${var.project_name_prefix}-nat-elasticip"
  }))
}

module "nat_gateway" {
  depends_on    = [module.subnet_main, module.elastic_ip]
  source        = "./modules/nat-gateway"
  allocation_id = module.elastic_ip.eip_id
  subnet_id     = lookup(lookup({ for k, bd in module.subnet_main : k => bd.subnet_id }, "public-subnet", ""), "public-subnet-1", "")
  tags = merge(var.tags, tomap({
    "Name" : "${var.project_name_prefix}-nat-gateway"
  }))
}

module "route_table_public" {
  depends_on          = [module.vpc_main, module.internet_gateway]
  for_each            = var.subnets
  source              = "./modules/route-table/public"
  vpc_id              = module.vpc_main.vpc_id
  gateway_id          = module.internet_gateway.internet_gateway_id
  name                = each.key
  is_public           = each.value.is_public
  cidr_block          = "0.0.0.0/0"
  tags                = var.tags
  project_name_prefix = var.project_name_prefix
}

module "route_table_private" {
  depends_on          = [module.vpc_main, module.internet_gateway]
  for_each            = var.subnets
  source              = "./modules/route-table/private"
  vpc_id              = module.vpc_main.vpc_id
  nat_gateway_id      = module.nat_gateway.nat_gateway_id
  name                = each.key
  nat_gateway         = each.value.nat_gateway
  cidr_block          = "0.0.0.0/0"
  tags                = var.tags
  project_name_prefix = var.project_name_prefix
}

module "route_table_association_public" {
  depends_on     = [module.subnet_main, module.route_table_public]
  for_each       = var.subnets
  source         = "./modules/route-table-association"
  subnet_ids     = lookup({ for k, bd in module.subnet_main : k => bd.subnet_id }, "public-subnet", {})
  route_table_id = lookup(lookup({ for k, bd in module.route_table_public : "${k}" => bd.rid }, "public-subnet", ""), "public-subnet-rt-1", "")
}

module "route_table_association_private" {
  depends_on     = [module.subnet_main, module.route_table_private]
  for_each       = var.subnets
  source         = "./modules/route-table-association"
  subnet_ids     = lookup({ for k, bd in module.subnet_main : k => bd.subnet_id }, "private-subnet", {})
  route_table_id = lookup(lookup({ for k, bd in module.route_table_private : "${k}" => bd.rid }, "private-subnet", ""), "private-subnet-rt-1", "")
}

module "security-group" {
  source      = "./modules/Security-group"
  for_each    = var.sg
  name        = each.value.name
  description = each.value.description
  vpc_id      = module.vpc_main.vpc_id
  tags = merge(var.tags, tomap({
    "Name" : "${var.project_name_prefix}-${each.value.name}-sg"
  }))
}

module "security_group_rule" {
  source            = "./modules/Security-group/Sg-rule"
  for_each          = var.sg-rule
  type              = each.value.type
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_block
  security_group_id = lookup({ for k, v in module.security-group : k => v.sg-id }, each.value.security_group_name, "")

}


module "public-nacl" {
  depends_on = [module.vpc_main]
  source     = "./modules/Nacl/Public"
  vpc_id     = module.vpc_main.vpc_id
  subnet_ids = values(lookup({ for k, bd in module.subnet_main : k => bd.subnet_id }, "public-subnet", {}))
  tags = merge(var.tags, tomap({
    "Name" : "${var.project_name_prefix}-NACL-Public"
  }))
}
module "public-nacl-rule" {
  source         = "./modules/Nacl/Public/Nacl-rules-public"
  for_each       = var.public-nacl-rules
  network_acl_id = module.public-nacl.public-nacl-id
  rule_number    = each.value.rule_number
  egress         = each.value.egress
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
}

module "private-nacl" {
  depends_on             = [module.vpc_main]
  source                 = "./modules/Nacl/Private"
  default_network_acl_id = module.vpc_main.nacl_id
  subnet_ids             = values(lookup({ for k, bd in module.subnet_main : k => bd.subnet_id }, "private-subnet", {}))
  tags = merge(var.tags, tomap({
    "Name" : "${var.project_name_prefix}-NACL-Private"
  }))
}

module "private-nacl-rule" {
  source         = "./modules/Nacl/Public/Nacl-rules-public"
  for_each       = var.public-nacl-rules
  network_acl_id = module.private-nacl.private-nacl-id
  rule_number    = each.value.rule_number
  egress         = each.value.egress
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
}


module "s3_gateway" {
  source          = "./modules/vpc-endpoint/gateway"
  service_name    = "com.amazonaws.${var.region}.s3"
  route_table_ids = [lookup(lookup({ for k, v in module.route_table_public : k => v.rid }, "public-subnet", ""), "public-subnet-1", ""), lookup(lookup({ for k, v in module.route_table_private : k => v.rid }, "private-subnet", ""), "private-subnet-1", "")]
  vpc_id          = module.vpc_main.vpc_id
  tags = merge(var.tags, tomap({
    "Name" : "${var.project_name_prefix}-s3-gateway"
  }))
}

module "vpc_endpoint_policy" {
  source          = "./modules/vpc-endpoint/Endpoint-Policy"
  vpc_endpoint_id = module.s3_gateway.vpc_endpoint_id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowAll",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "*"
        },
        "Action" : [
          "dynamodb:*"
        ],
        "Resource" : "*"
      }
    ]
  })
}
module "ec2_interface" {
  source             = "./modules/vpc-endpoint/interface"
  security_group_ids = [lookup({ for k, v in module.security-group : k => v.sg-id }, "sg1", "")]
  service_name       = "com.amazonaws.${var.region}.ec2"
  subnet_ids         = values(lookup({ for k, bd in module.subnet_main : k => bd.subnet_id }, "private-subnet", {}))
  vpc_id             = module.vpc_main.vpc_id
  # private_dns_enabled = var.private_dns_enabled
  tags = merge(var.tags, tomap({
    "Name" : "${var.project_name_prefix}-ec2-interface"
  }))
}

module "aws_vpc_peering_connection" {
  source        = "./modules/vpc_peering"
  vpc_id        = module.vpc_main.vpc_id
  peer_vpc_id   = var.peer_vpc_id
  peer_owner_id = var.peer_owner_id
  auto_accept   = var.auto_accept
  peer_region   = var.peer_region
}

# module "aws_vpc_peering_connection_accepter" {
#   source= "./modules/Vpc_peering_accepter"
#   vpc_peering_connection_id = module.aws_vpc_peering_connection.vpc_peering_connection_id
#   auto_accept_peering = true
# }

# resource "aws_route" "aws_route_peering" {
#   # count                     = var.create_peering_routes ? length(var.destination_cidr_blocks) : 0
#   route_table_id            = "rtb-011ae02e8b6ec8261"
#   destination_cidr_block    = "172.31.0.0/16"
#   vpc_peering_connection_id = module.aws_vpc_peering_connection.vpc_peering_connection_id
# }