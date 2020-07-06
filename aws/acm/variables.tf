variable "aws_region" {
  description = "AWS region for provider"
}

variable "domain_name" {
  description = "A domain name for which the certificate should be issued"
}

variable "route53_zone_name" {
  description = "The Route53 Zone name where to create the ACM validation records"
}

variable "sans" {
  description = "A list of domains that should be SANs in the issued certificate"
  type        = list(string)
}

variable "tags" {
  description = "Tags to be used on most resources"
  type        = map(string)

  validation {
    condition     = length(var.tags) != 0
    error_message = "We need tags!"
  }
}
