variable "aws_region" {
  description = "AWS region for provider"
}

variable "lifecycle_policy_image_count" {
  default     = 20
  description = "If greater than 0, creates lifecycle policy to keep last N number of images, where N is the value passed in this var"
}

variable "repository_name" {
  description = "ECR Repository name"
}

variable "tags" {
  description = "Tags to be used on most resources"
  type        = map(string)

  validation {
    condition     = length(var.tags) != 0
    error_message = "We need tags!"
  }
}
