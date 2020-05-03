locals {
  # split the main cidr in smaller blocks
  #  to create 1 public and 1 private subnets per availability zone

  zones_names = data.aws_availability_zones.zones.names
  # get the number of bits to transfer from host part to network part
  #  e.g. for 6 zones we have to split the main cidr block in 16,
  #  so we need to add 4 new bits to the network preifx
  #  ceil(log(6, 2)) + 1 = 4
  newbits = ceil(log(length(local.zones_names), 2)) + 1

  private_subnets_cidrs = [ for k, zone_name in local.zones_names:
    {
      cidr_block: cidrsubnet(var.cidr_block, local.newbits, k * 2),
      name: "private.${zone_name}",
      zone_name: zone_name,
    }
  ]

  public_subnets_cidrs = [ for k, zone_name in local.zones_names:
    {
      cidr_block: cidrsubnet(var.cidr_block, local.newbits + 1, (k * 2 + 1) * 2),
      name: "public.${zone_name}",
      zone_name: zone_name,
    }
  ]

}

data "aws_availability_zones" "zones" {}

resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  tags = var.vpc_tags
}

resource "aws_subnet" "private" {
  count = length(local.private_subnets_cidrs)

  vpc_id     = aws_vpc.vpc.id
  availability_zone = local.private_subnets_cidrs[count.index].zone_name
  cidr_block = local.private_subnets_cidrs[count.index].cidr_block

  tags = merge({
    Name = local.private_subnets_cidrs[count.index].name
  }, var.subnets_tags)
}

resource "aws_subnet" "public" {
  count = length(local.public_subnets_cidrs)

  vpc_id            = aws_vpc.vpc.id
  availability_zone = local.public_subnets_cidrs[count.index].zone_name
  cidr_block        = local.public_subnets_cidrs[count.index].cidr_block

  tags = merge({
    Name = local.public_subnets_cidrs[count.index].name
  }, var.subnets_tags)
}


