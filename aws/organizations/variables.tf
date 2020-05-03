variable "aws_region" {
  description = "AWS region for provider"
}

variable "account_identity" {
  description = "AWS account details for the identity account"
  type = object({
    email               = string
    name                = string
    organizational_unit = string
  })
}

variable "account_non_prod" {
  description = "AWS account details for the non-prod account"
  type = object({
    email               = string
    name                = string
    organizational_unit = string
  })
}
