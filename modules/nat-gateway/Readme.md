# **Terraform vpc-modules vpc**

*Creates a Nat Gateway*


#  Usage

module "nat_gateway" {
  depends_on    = [module.subnet_main, module.elastic_ip]
  source        = "./modules/nat-gateway"
  allocation_id = module.elastic_ip.eip_id
  subnet_id = lookup(lookup(lookup({ for k, bd in module.subnet_main : k => bd.subnet_id }, "public-subnet", ""), "subnet-0", ""), "subnet_id", "")
  tags = merge(var.tags, tomap({
    "Name" : "${var.project_name_prefix}-nat-gateway"
  }))
}


##  Inputs
|Name |Description |Type |Default |Required                         |
|-----|-----|-----|-----|-----|
|allocation_id|The CIDR block for the VPC|string|-|yes|
|subnet_id|Enable DNS hostnames in the VPC|string|false|yes|
|tags|A map of tags to assign to resources|map|-|no|

##  Outputs
|Name |Description |
|------|--------|
|vpc_id|The VPC Id|

