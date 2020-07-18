resource "aws_ecr_repository" "repositories" {
  for_each = var.repositories_names

  name                 = each.value
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }

  tags = var.tags
}
