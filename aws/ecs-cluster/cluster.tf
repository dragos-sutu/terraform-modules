resource "aws_ecs_cluster" "cluster" {
  capacity_providers = ["FARGATE"]
  name               = var.cluster_name

  tags = merge({
    Name = "${var.cluster_name}.cluster.ecs",
  }, var.tags)
}
