variable "aws_region" {
  description = "AWS region for provider"
}

variable "cidr_block" {
  description = "CIDR block"
  type        = string
}

variable "vpc_tags" {
  description = "VPC tags"
  type        = map(string)
}

variable "subnets_tags" {
  description = "Subnets tags"
  type        = map(string)
}
