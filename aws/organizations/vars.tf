variable "aws_region" {
  description = "AWS region for provider"
}

variable "account_identity" {
  description = "AWS account details for the Identity account"
  type = object({
    email               = string
    name                = string
    organizational_unit = string
  })
}

variable "account_dev" {
  description = "AWS account details for the Dev account"
  type = object({
    email               = string
    name                = string
    organizational_unit = string
  })
}
