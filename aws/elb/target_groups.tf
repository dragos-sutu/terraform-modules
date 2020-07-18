locals {
  target_groups = { for tg in var.target_groups:
    tg.name => tg
  }
}

resource "aws_lb_target_group" "target_groups" {
  for_each = local.target_groups

  name        = each.value.name
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  tags = merge({
    Name = "${each.value.name}.tg",
  }, var.tags)
}
