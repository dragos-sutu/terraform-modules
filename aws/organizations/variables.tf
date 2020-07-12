variable "aws_region" {
  description = "AWS region for provider"
}

variable "organizational_units" {
  description = "AWS organizational units to create"
  type        = set(string)
}

variable "accounts" {
  description = "AWS child accounts to create, accounts.organizational_unit must match a value from var.organizational_units"
  type        = list(object({
    email: string,
    name: string,
    organizational_unit: string,
  }))
}
