output "id" {
  value = aws_vpc.vpc.id
}

output "subnets_private_ids" {
  value = values(aws_subnet.private)[*].id
}

output "subnets_public_ids" {
  value = values(aws_subnet.public)[*].id
}
