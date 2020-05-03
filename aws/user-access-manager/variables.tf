variable "aws_region" {
  description = "AWS region for provider"
}

variable "managed_accounts_ids" {
  description = "ids of the AWS accounts that the administrator user will manage"
  type        = list(string)

  validation {
    condition     = length(var.managed_accounts_ids) != 0
    error_message = "Invalid managed_accounts_ids var."
  }
}

variable "pgp_key" {
  description = "base64 encoded PGP public key that will be used to encrypt the AWS login password"
  type        = string

  validation {
    condition     = length(var.pgp_key) != 0
    error_message = "Invalid pgp_key var."
  }
}
