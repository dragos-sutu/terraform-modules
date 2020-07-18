resource "aws_db_subnet_group" "db" {
  name       = var.name
  subnet_ids = values(aws_subnet.private)[*].id

  tags = merge({
    Name = "${var.name}.private.db-subnet-group",
  }, var.tags)
}
