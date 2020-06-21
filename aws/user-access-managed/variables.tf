variable "aws_region" {
  description = "AWS region for provider"
}

variable "manager_account_id" {
  description = "id of the AWS account that will manage current account by assuming role"
  type        = string

  validation {
    condition     = length(var.manager_account_id) != 0
    error_message = "Invalid manager_account_id var."
  }
}
