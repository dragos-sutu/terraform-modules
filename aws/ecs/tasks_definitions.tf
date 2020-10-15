resource "aws_ecs_task_definition" "task" {
  container_definitions    = file(var.task_definition.container_definitions_file_path)
  cpu                      = var.task_definition.cpu
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  family                   = var.task_definition.name
  memory                   = var.task_definition.memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  tags = merge({
    Name = "${var.task_definition.name}.task.ecs",
  }, var.tags)
}
