# **Terraform vpc-modules elastic ip**

*Creates a elastic ip*


#  Usage

module "elastic_ip" {
  source = "./modules/elastic-ip"
  tags = merge(var.tags, tomap({
    "Name" : "${var.project_name_prefix}-nat-elasticip"
  }))
}


##  Inputs
|Name |Description |Type |Default |Required                         |
|-----|-----|-----|-----|-----|
|tags|A map of tags to assign to resources|map|-|no|

##  Outputs
|Name |Description |
|------|--------|
|eip_id|Contains the EIP allocation ID.|

