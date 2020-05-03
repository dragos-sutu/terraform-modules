variable "aws_region" {
  description = "AWS region for provider"
}

variable "key_name" {
  description = "the name that will be used for the key"
  type = string

  validation {
    condition     = length(var.key_name) != 0
    error_message = "Key name cannot be empty."
  }
}

variable "public_key" {
  description = "the public key of the SSH key pair"
  type = string

  validation {
    condition     = length(var.public_key) != 0
    error_message = "Public key cannot be empty."
  }
}

variable "tags" {
  description = "tags that will be added to the SSH key"
  type = map(string)

  validation {
    condition     = length(var.tags) != 0
    error_message = "Tags cannot be empty."
  }
}
