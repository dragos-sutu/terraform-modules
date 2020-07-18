variable "aws_region" {
  description = "AWS region for provider"
}

variable "zone_name" {
  description = "Name of the hosted zone that will be created"
}

variable "tags" {
  description = "Tags to be used on most resources"
  type        = map(string)

  validation {
    condition     = length(var.tags) != 0
    error_message = "We need tags!"
  }
}
