# **Terraform vpc-modules vpc**

*Creates a VPC*


#  Usage

module "vpc_main" {

source =  "./modules/vpc"

cidr_block = var.cidr_block

enable_dns_hostnames = var.enable_dns_hostnames

enable_dns_support = var.enable_dns_support

tags =  merge(var.tags, tomap({

"Name" : "${var.project_name_prefix}-vpc"

}))

}


##  Inputs
|Name |Description |Type |Default |Required                         |
|-----|-----|-----|-----|-----|
|cidr_block|The CIDR block for the VPC|string|-|yes|
|enable_dns_hostnames|Enable DNS hostnames in the VPC|string|false|no|
|enable_dns_support|Enable DNS support in the VPC|string|true|no|
|tags|A map of tags to assign to resources|map|-|no|

##  Outputs
|Name |Description |
|------|--------|
|vpc_id|The VPC Id|
nacl_id|The Nacl id|
