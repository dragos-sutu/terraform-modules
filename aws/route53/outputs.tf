output "name_servers" {
  value = { for zone in aws_route53_zone.zones:
    zone.name => zone.name_servers
  }
}
