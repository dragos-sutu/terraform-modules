resource "aws_nat_gateway" "gw" {
  for_each = local.nat_gw_subnets

  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = aws_subnet.public[each.key].id

  tags = merge({
    Name = "${var.name}.${each.key}",
  }, var.tags)

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_route" "private_default" {
  for_each = local.nat_gw_subnets

  route_table_id         = aws_route_table.private[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.gw[each.key].id
}

resource "aws_eip" "nat" {
  for_each = local.nat_gw_subnets

  vpc = true

  tags = merge({
    Name = "${var.name}.nat.${each.key}",
  }, var.tags)

  depends_on = [aws_internet_gateway.gw]
}
