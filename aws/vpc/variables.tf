variable "aws_region" {
  description = "AWS region for provider"
}

variable "cidr_block" {
  description = "CIDR block"
  type        = string
}

variable "name" {
  description = "Name to be used on most resources."
  type        = string
}

variable "selected_zones" {
  description = "Availability zones where resources will be created"
  type        = list(string)
}

variable "tags" {
  description = "Tags to be used on most resources"
  type        = map(string)
}
