# **Terraform vpc-modules internet-gateway**

*Creates a Internet Gateway*


#  Usage

module "internet_gateway" {
  depends_on = [module.vpc_main]
  source     = "./modules/internet-gateway"
  vpc_id     = module.vpc_main.vpc_id

  tags = merge(var.tags, tomap({
    "Name" : "${var.project_name_prefix}-ig"
  }))
}

##  Inputs
|Name |Description |Type |Default |Required                         |
|-----|-----|-----|-----|-----|
|vpc_id|An ID for VPC of the environment|string|-|yes|
|tags|A map of tags to assign to resources|map|-|no|

##  Outputs
|Name |Description |
|------|--------|
|internet_gateway_id|The Internet Gateway Id|

