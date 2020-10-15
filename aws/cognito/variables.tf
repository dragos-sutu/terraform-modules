variable "aws_region" {
  description = "AWS region for provider"
}

variable "clients" {
  description = "A list of objects, for each one a Cognito User Pool Client will be created and attached to the User Pool"
  type        = list(object({
    callback_urls: list(string),
    explicit_auth_flows: list(string),
    generate_secret: bool,
    logout_urls: list(string),
    name: string,
    refresh_token_validity: string,
  }))
}

variable "from_email_address" {
  description = "Sender’s email address or sender’s display name with their email address"
}

variable "from_email_address_arn" {
  description = "The ARN of the SES verified email identity to use"
}

variable "custom_message_lambda_arn" {
  description = "ARN of the Lambda Function that is executed before email verification or MFA message is sent"
}

variable "custom_message_lambda_name" {
  description = "Name of the Lambda Function that is executed before email verification or MFA message is sent"
}

variable "reply_to_email_address" {
  description = "The REPLY-TO email address"
}

variable "user_pool_standard_attributes" {
  description = "User pool standard attributes from OpenID Connect specification"
  type        = list(object({
    mutable: bool,
    name: string,
  }))
}

variable "user_pool_name" {
  description = "User pool name"
}

variable "tags" {
  description = "Tags to be used on most resources"
  type        = map(string)

  validation {
    condition     = length(var.tags) != 0
    error_message = "We need tags!"
  }
}
