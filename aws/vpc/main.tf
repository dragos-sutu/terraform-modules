locals {
  # split the main cidr in smaller blocks
  #  to create 1 public and 1 private subnets per availability zone

  zones_names = data.aws_availability_zones.zones.names
  # get the number of bits to transfer from host part to network part
  #  e.g. for 6 zones we have to split the main cidr block in 16,
  #  so we need to add 4 new bits to the network preifx
  #  ceil(log(6, 2)) + 1 = 4
  newbits     = ceil(log(length(local.zones_names), 2)) + 1

  private_subnets = [for k, zone_name in local.zones_names:
    {
      cidr_block: cidrsubnet(var.cidr_block, local.newbits, k * 2),
      zone_name: zone_name,
    }
    if contains(var.selected_zones, zone_name)
  ]

  public_subnets = [for k, zone_name in local.zones_names:
    {
      cidr_block: cidrsubnet(var.cidr_block, local.newbits + 1, (k * 2 + 1) * 2),
      zone_name: zone_name,
    }
    if contains(var.selected_zones, zone_name)
  ]
}

data "aws_availability_zones" "zones" {}

resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  tags = merge({
    Name = var.name,
  }, var.tags)
}
