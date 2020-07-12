variable "aws_region" {
  description = "AWS region for provider"
}

variable "groups" {
  default     = []
  description = "Groups to be created. policies_aws_managed_arns must contain valid AWS managed policies ARNs. policies_customer_managed_names must contain valid customer managed policies name, that can be created with var.policies"
  type        = list(object({
    name: string,
    policies_aws_managed_arns: list(string),
    policies_customer_managed_names: list(string),
  }))
}

variable "policies" {
  default     = []
  description = "Policies to be created, only sts:AssumeRole is used as action"
  type        = list(object({
    description: string,
    name: string,
    resources: list(string),
  }))
}

variable "roles" {
  default     = []
  description = "Roles to be created, supports only AWS accounts as trusted entities"
  type        = list(object({
    name: string,
    policies_aws_managed_arns: list(string),
    trusted_account: string,
  }))
}

variable "users" {
  default     = []
  description = "Users to be created, groups must contain existing groups names, that can be created with var.groups"
  type        = list(object({
    groups_names: list(string),
    login_profile: bool,
    name: string,
    pgp_key: string,
  }))
}
