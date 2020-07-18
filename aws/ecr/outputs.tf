output "repositories_urls" {
  value = { for r in aws_ecr_repository.repositories:
    r.name => r.repository_url
  }
}
