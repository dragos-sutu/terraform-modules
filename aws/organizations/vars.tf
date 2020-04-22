variable "accounts" {
  description = "list of accounts names and emails"
  type = list(object({
    email = string
    name = string
  }))
}

variable "aws_region" {
  description = "AWS region for provider"
}
