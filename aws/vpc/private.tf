resource "aws_subnet" "private" {
  count = length(local.private_subnets)

  vpc_id            = aws_vpc.vpc.id
  availability_zone = local.private_subnets[count.index].zone_name
  cidr_block        = local.private_subnets[count.index].cidr_block

  tags = merge({
    Name = "${var.name}.private.${local.private_subnets[count.index].zone_name}",
  }, var.tags)
}

resource "aws_route_table_association" "private" {
  count = length(local.private_subnets)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

resource "aws_route_table" "private" {
  count = length(local.public_subnets)

  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw[count.index].id
  }

  tags = merge({
    Name = "${var.name}.private.${local.private_subnets[count.index].zone_name}",
  }, var.tags)
}
