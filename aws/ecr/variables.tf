variable "aws_region" {
  description = "AWS region for provider"
}

variable "repositories_names" {
  description = "Set of ECR Repositories names, one per image"
  type        = set(string)
}

variable "tags" {
  description = "Tags to be used on most resources"
  type        = map(string)

  validation {
    condition     = length(var.tags) != 0
    error_message = "We need tags!"
  }
}
