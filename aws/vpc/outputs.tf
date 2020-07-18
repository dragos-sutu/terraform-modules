output "id" {
  value = aws_vpc.vpc.id
}

output "subnets_private_ids" {
  value = values(aws_subnet.private)[*].id
}

output "subnets_public_ids" {
  value = values(aws_subnet.public)[*].id
}

output "subnet_db_group_id" {
  value = aws_db_subnet_group.db.id
}
