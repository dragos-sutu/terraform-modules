resource "aws_nat_gateway" "gw" {
  for_each = local.nat_gw_subnets

  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = aws_subnet.public[each.key].id

  tags = merge({
    Name = "${var.name}.${each.key}.nat-gw",
  }, var.tags)

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_route" "private_default_nat_gw" {
  for_each = local.nat_gw_subnets

  route_table_id         = aws_route_table.private[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.gw[each.key].id
}

resource "aws_eip" "nat" {
  for_each = local.nat_gw_subnets

  vpc = true

  tags = merge({
    Name = "${var.name}.nat.${each.key}.eip",
  }, var.tags)

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_security_group" "nat" {
  name   = "${var.name}.nat.sg"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.management_cidr]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = "${var.name}.nat.sg",
  }, var.tags)
}

data "aws_ami" "nat" {
  most_recent  = true

  filter {
    name   = "name"
    values = ["amzn-ami-vpc-nat*"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "nat" {
  ami                         = data.aws_ami.nat.id
  availability_zone           = local.nat_instance_zone
  instance_type               = var.nat_instance_type
  key_name                    = var.nat_instance_key_name
  vpc_security_group_ids      = [aws_security_group.nat.id]
  subnet_id                   = aws_subnet.public[local.nat_instance_zone].id
  associate_public_ip_address = true
  source_dest_check           = false

  tags = merge({
    Name = "${var.name}.nat.ec2-inst",
  }, var.tags)
}

resource "aws_route" "private_default_nat_instance" {
  for_each = local.private_subnets

  route_table_id         = aws_route_table.private[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  instance_id            = aws_instance.nat.id
}
