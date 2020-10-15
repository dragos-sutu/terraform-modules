locals {
  target_groups = { for tg in var.target_groups:
    tg.name => tg
  }
}

resource "aws_lb_target_group" "target_groups" {
  for_each = local.target_groups

  health_check {
    enabled = true
    matcher = "200"
    path    = each.value.healthcheck_path
  }

  name        = each.value.name
  port        = each.value.port
  protocol    = each.value.protocol
  target_type = "ip"
  vpc_id      = var.vpc_id

  tags = merge({
    Name = "${each.value.name}.tg",
  }, var.tags)
}
