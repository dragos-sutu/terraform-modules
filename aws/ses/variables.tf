variable "aws_region" {
  description = "AWS region for provider"
}

variable "email_address" {
  description = "Email address that will be verified by SES"
}

variable "tags" {
  description = "Tags to be used on most resources"
  type        = map(string)

  validation {
    condition     = length(var.tags) != 0
    error_message = "We need tags!"
  }
}
