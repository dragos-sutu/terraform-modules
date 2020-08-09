variable "aws_region" {
  description = "AWS region for provider"
}

variable "function_name" {
  description = "A unique name for your Lambda Function"
}

variable "handler" {
  default     = "main"
  description = "The function entrypoint in your code"
}

variable "payload_zip_path" {
  description = "The path to the function's deployment package within the local filesystem"
}

variable "runtime" {
  default     = "go1.x"
  description = "The identifier of the function's runtime, e.g. nodejs12.x, python3.8, go1.x"
}

variable "tags" {
  description = "Tags to be used on most resources"
  type        = map(string)

  validation {
    condition     = length(var.tags) != 0
    error_message = "We need tags!"
  }
}
