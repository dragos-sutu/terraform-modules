variable "aws_region" {
  description = "AWS region for provider"
}

variable "listener_certificate_arn" {
  description = "ARN of the certificate that will be attached on the listener"
}

variable "name" {
  description = "ALB name"
}

variable "route53_record_name" {
  description = "URL that will point to the ELB, will be used as the route53 record name"
}

variable "route53_zone_id" {
  description = "Id of the route53 zone where the record for the ELB will be created"
}

variable "subnets_ids" {
  description = "Ids of the subnets that the ELB will be associated with"
  type = list(string)
}

variable "tags" {
  description = "Tags to be used on most resources"
  type        = map(string)

  validation {
    condition     = length(var.tags) != 0
    error_message = "We need tags!"
  }
}

variable "target_groups" {
  description = "Target groups that will be created and associated with the ELB"
  type = list(object({
    name: string,
    port: string,
    protocol: string,
  }))
}

variable "vpc_id" {
  description = "Id of the VPC where the ELB will be created"
}
