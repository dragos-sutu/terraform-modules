variable "aws_region" {
  description = "AWS region for provider"
}

variable "accounts" {
  description = "list of account objects, each containing account email, name and the organizational unit name that the account belongs to"
  type        = list(object({
    email               = string
    name                = string
    organizational_unit = string
  }))
}

variable "organizational_units" {
  description = "list of organizational units names"
  type        = list(string)
}
