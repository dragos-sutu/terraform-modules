resource "aws_ecs_service" "service" {
  cluster                            = var.cluster_id
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  desired_count                      = var.service.desired_count
  enable_ecs_managed_tags            = true
//  health_check_grace_period_seconds  = 30
  launch_type                        = "FARGATE"

  load_balancer {
    container_name   = var.service.lb_container_name
    container_port   = var.service.lb_container_port
    target_group_arn = var.service.lb_target_group_arn
  }

  name = var.service.name

  network_configuration {
    assign_public_ip = false
    security_groups  = [aws_security_group.service.id]
    subnets          = var.service.subnets
  }

  platform_version = "1.4.0"
  propagate_tags   = "SERVICE"
  tags             = merge({
    Name = "${var.service.name}.service.ecs",
  }, var.tags)

  task_definition = aws_ecs_task_definition.task.arn

  lifecycle {
    ignore_changes = [desired_count]
  }
}
