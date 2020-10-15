variable "aws_region" {
  description = "AWS region for provider"
}

variable "domain_name" {
  description = "A domain name for which the certificate should be issued"
}

variable "for_cloudfront" {
  default     = false
  description = "True if it's a Cloudfront certificate, in which case it has to be create in North Virginia region"
  type        = bool
}

variable "route53_zone_id" {
  description = "Id of the Route53 Zone where the ACM validation records will be created"
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
