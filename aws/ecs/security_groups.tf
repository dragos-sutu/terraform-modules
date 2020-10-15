resource "aws_security_group" "service" {
  name   = "${var.service.name}.ecs-service.sg"
  vpc_id = var.vpc_id

  tags = merge({
    Name = "${var.service.name}.ecs-service.sg",
  }, var.tags)
}

resource "aws_security_group_rule" "ingress_cidr" {
  count = var.service.ingress_source.cidr_blocks ? 1 : 0

  type              = "ingress"
  from_port         = var.service.ingress_source.port
  to_port           = var.service.ingress_source.port
  protocol          = "tcp"
  cidr_blocks       = var.service.ingress_source.cidr_blocks
  security_group_id = aws_security_group.service.id
}

resource "aws_security_group_rule" "ingress_sg" {
  count = var.service.ingress_source.security_group_id ? 1 : 0

  type                     = "ingress"
  from_port                = var.service.ingress_source.port
  to_port                  = var.service.ingress_source.port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.service.id
  source_security_group_id = var.service.ingress_source.security_group_id
}

resource "aws_security_group_rule" "egress_allow_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.service.id
}
