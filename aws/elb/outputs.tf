output "target_groups" {
  value = { for tg in aws_lb_target_group.target_groups:
    tg.name => tg.arn
  }
}

output "security_group_id" {
  value = aws_security_group.alb.id
}
