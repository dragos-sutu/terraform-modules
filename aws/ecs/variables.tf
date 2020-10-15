variable "aws_region" {
  description = "AWS region for provider"
}

variable "cluster_id" {
  description = "Id of the ECS Cluster to be used by the Services"
}

variable "cw_log_group_name" {
  description = "Name of the Cloudwatch Log Group to create"
}

variable "cw_log_group_retention" {
  default     = 30
  description = "Cloudwatch Log Group retention time in days"
}

variable "service" {
  description = "Info required to create an ECS Service name"
  type        = object({
    desired_count: number,
    ingress_source: object({
      cidr_blocks: list(string),
      port: string,
      security_group_id: string,
    }),
    lb_container_name: string,
    lb_container_port: number,
    lb_target_group_arn: string,
    name: string,
    subnets: list(string),
  })
}

variable "task_definition" {
  description = "Info required to create an ECS Task Definition"
  type        = object({
    container_definitions_file_path: string,
    cpu: string,
    memory: string,
    name: string,
  })
}

variable "tags" {
  description = "Tags to be used on most resources"
  type        = map(string)

  validation {
    condition     = length(var.tags) != 0
    error_message = "We need tags!"
  }
}

variable "vpc_id" {
  description = "Id of the VPC where the resources will be created"
}
