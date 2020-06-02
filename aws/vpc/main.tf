locals {
  # split the main cidr in smaller blocks
  #  to create 1 public and 1 private subnets per availability zone

  zones_names = data.aws_availability_zones.zones.names
  # get the number of bits to transfer from host part to network part
  #  e.g. for 6 zones we have to split the main cidr block in 16,
  #  so we need to add 4 new bits to the network preifx
  #  ceil(log(6, 2)) + 1 = 4
  newbits     = ceil(log(length(local.zones_names), 2)) + 1

  private_subnets = {for k, zone_name in local.zones_names:
    zone_name => cidrsubnet(var.cidr_block, local.newbits, k * 2)
    if contains(var.availability_zones, zone_name)
  }

  public_subnets = {for k, zone_name in local.zones_names:
    zone_name => cidrsubnet(var.cidr_block, local.newbits + 1, (k * 2 + 1) * 2)
    if contains(var.availability_zones, zone_name)
  }

  # if NAT is implemented with NAT gateways, put a NAT gateway in each public subnet
  #  else if NAT instance, use a single EC2 instance in the first subnet
  nat_gw_subnets = var.nat == "gateway" ? local.public_subnets : {}

  nat_instance_zone = var.availability_zones[0]
}

data "aws_availability_zones" "zones" {}

resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  tags = merge({
    Name = var.name,
  }, var.tags)
}
