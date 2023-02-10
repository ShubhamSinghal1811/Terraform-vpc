cidr_block           = "10.10.0.0/16"
enable_dns_support   = true
enable_dns_hostnames = true
project_name_prefix  = "lty-NonProd"
region               = "us-east-1"
peer_vpc_id          = "vpc-042bbb9364ffb359c"
peer_owner_id        = 432125190050
peer_region          = "ap-south-1"
auto_accept          = false

tags = {
  "Environment" : "Dev"
  "Description" : "for Developers"
}

subnets = {
  "public-subnet" = {
    is_public = true
    vpc_index = 0

    nat_gateway = false
    details = [
      {
        availability_zone = "a"
        cidr_block        = "10.10.0.0/24"
      },
      {
        availability_zone = "b"
        cidr_block        = "10.10.1.0/24"
      },
      {
        availability_zone = "c"
        cidr_block        = "10.10.2.0/24"
      }
    ]
  }

  "private-subnet" = {
    is_public   = false
    vpc_index   = 0
    nat_gateway = true
    details = [
      {
        availability_zone = "a"
        cidr_block        = "10.10.3.0/24"
      },
      {
        availability_zone = "b"
        cidr_block        = "10.10.4.0/24"
      },
      {
        availability_zone = "c"
        cidr_block        = "10.10.5.0/24"
      }
    ]
  }



}


sg = {
  "sg1" = {
    name        = "vpc-endpoint"
    description = "demo"
  }
  "sg2" = {
    name        = "demo1"
    description = "demo1"
  }

}

sg-rule = {
  "sg-rule-1" = {
    type       = "ingress"
    from_port  = 0
    to_port    = 65535
    protocol   = "tcp"
    cidr_block = "10.10.0.0/16"
    # ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
    security_group_name = "sg1"
    # security_group_id=lookup({for k,v in module.security-group:k=>v.sg-id},sg1,"")
  }
  "sg-rule-2" = {
    type       = "egress"
    from_port  = 0
    to_port    = 65535
    protocol   = "all"
    cidr_block = "0.0.0.0/0"
    # ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
    security_group_name = "sg1"
    # security_group_id=lookup({for k,v in module.security-group:k=>v.sg-id},sg1,"")
  }
  "sg-rule-3" = {
    type       = "egress"
    from_port  = 0
    to_port    = 65535
    protocol   = "tcp"
    cidr_block = "10.10.0.0/16"
    # ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
    security_group_name = "sg2"
  }
}


public-nacl-rules = {
  "egress" = {
    cidr_block = "0.0.0.0/0"
    egress     = true
    from_port  = 0
    # network_acl_id = "value"
    protocol    = "-1"
    rule_action = "allow"
    rule_number = 100
    to_port     = 0
  }
  "ingress" = {
    cidr_block = "0.0.0.0/0"
    egress     = false
    from_port  = 0
    # network_acl_id = ""
    protocol    = "-1"
    rule_action = "allow"
    rule_number = 100
    to_port     = 0
  }
}

private-nacl-rules = {
  "egress" = {
    cidr_block = "0.0.0.0/0"
    egress     = true
    from_port  = 0
    # network_acl_id = "value"
    protocol    = "-1"
    rule_action = "allow"
    rule_number = 100
    to_port     = 0
  }
  "ingress" = {
    cidr_block = "0.0.0.0/0"
    egress     = false
    from_port  = 0
    # network_acl_id = ""
    protocol    = "-1"
    rule_action = "allow"
    rule_number = 100
    to_port     = 0
  }
}