resource "aws_subnet" "public" {
  count = length(local.public_subnets)

  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = local.public_subnets[count.index].zone_name
  cidr_block              = local.public_subnets[count.index].cidr_block
  map_public_ip_on_launch = true

  tags = merge({
    Name = "${var.name}.public.${local.private_subnets[count.index].zone_name}",
  }, var.tags)
}

resource "aws_route_table_association" "public" {
  count = length(local.public_subnets)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = merge({
    Name = "${var.name}.public",
  }, var.tags)
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge({
    Name = var.name,
  }, var.tags)
}

resource "aws_nat_gateway" "gw" {
  count = length(local.public_subnets)

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = merge({
    Name = "${var.name}.${local.public_subnets[count.index].zone_name}",
  }, var.tags)

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_eip" "nat" {
  count = length(local.public_subnets)

  vpc = true

  tags = merge({
    Name = "${var.name}.nat.${local.public_subnets[count.index].zone_name}",
  }, var.tags)

  depends_on = [aws_internet_gateway.gw]
}
