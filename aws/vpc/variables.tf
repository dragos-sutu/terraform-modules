variable "aws_region" {
  description = "AWS region for provider"
}

variable "availability_zones" {
  description = "Availability zones where resources will be created"
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) != 0
    error_message = "At least 1 availability zone is required."
  }
}

variable "cidr_block" {
  description = "CIDR block"
  type        = string

  validation {
    condition     = length(var.cidr_block) != 0
    error_message = "CIDR block cannot be empty."
  }
}

variable "name" {
  description = "Name to be used on most resources."
  type        = string

  validation {
    condition     = length(var.name) != 0
    error_message = "Name cannot be empty."
  }
}

variable "nat" {
  description = "NAT implementation method: gateway or EC2 instance"
  type        = string

  validation {
    condition     = var.nat == "gateway" || var.nat == "instance"
    error_message = "Missing or invalid NAT implementation option."
  }
}

variable "tags" {
  description = "Tags to be used on most resources"
  type        = map(string)

  validation {
    condition     = length(var.tags) != 0
    error_message = "We need tags!"
  }
}
