variable "aws_region" {
  description = "AWS region for provider"
}

variable "groups" {
  default     = []
  description = "Groups to be created. policies_aws_managed_arns must contain valid AWS managed policies ARNs. policies_customer_managed_names must contain valid customer managed policies name, that can be created with var.policies"
  type        = list(object({
    policies_aws_managed_arns: list(string),
    policies_customer_managed_names: list(string),
    name: string,
  }))
}

variable "policies" {
  default     = []
  description = "Policies to be created, template_name and template_variables must match a template file in the module"
  type        = list(object({
    description: string,
    name: string,
    template_name: string,
    template_variables: map(string),
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
