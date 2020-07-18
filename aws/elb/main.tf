resource "aws_lb" "alb" {
  enable_deletion_protection = true
  internal                   = false
  load_balancer_type         = "application"
  name_prefix                = var.name
  security_groups            = [aws_security_group.alb.id]
  subnets                    = var.subnets_ids

  tags = merge({
    Name = "${var.name}.alb",
  }, var.tags)
}

resource "aws_route53_record" "route53_record" {
  zone_id = var.route53_zone_id
  name    = var.route53_record_name
  type    = "A"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}
