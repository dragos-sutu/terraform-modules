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

  validation {
    condition     = length(var.cidr_block) != 0
    error_message = "CIDR block cannot be empty."
  }
}

variable "management_cidr" {
  description = "CIDR block of management IP address(es)"
}

variable "name" {
  description = "Name to be used on most resources."

  validation {
    condition     = length(var.name) != 0
    error_message = "Name cannot be empty."
  }
}

variable "nat_type" {
  description = "NAT implementation method: gateway or EC2 instance"
  default     = "GATEWAY"

  validation {
    condition     = var.nat_type == "GATEWAY" || var.nat_type == "INSTANCE"
    error_message = "Missing or invalid NAT implementation option."
  }
}

variable "nat_instance_key_name" {
  description = "NAT instance SSH key name"
  default     = ""
}

variable "nat_instance_type" {
  description = "NAT EC2 instance type"
  default     = "t2.micro"
}

variable "tags" {
  description = "Tags to be used on most resources"
  type        = map(string)

  validation {
    condition     = length(var.tags) != 0
    error_message = "We need tags!"
  }
}
