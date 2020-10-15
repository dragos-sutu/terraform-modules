resource "aws_cloudwatch_log_group" "log_group" {
  name              = var.cw_log_group_name
  retention_in_days = var.cw_log_group_retention

  tags = merge({
    Name = "${var.cw_log_group_name}.group.cw",
  }, var.tags)
}
