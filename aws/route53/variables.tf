variable "aws_region" {
  description = "AWS region for provider"
}

variable "alias_records" {
  default     = []
  description = "A list of objects, for each one an aws_route53_records alias will be created"

  type = list(object({
    alias: object({
      name: string,
      zone_id: string,
    }),
    name: string,
    type: string,
    zone_name: string,
  }))
}

variable "records" {
  default     = []
  description = "A list of objects, for each one an aws_route53_record will be created"

  type = list(object({
    name: string,
    records: list(string),
    ttl: string
    type: string,
    zone_id: string,
  }))
}

variable "tags" {
  description = "Tags to be used on most resources"
  type        = map(string)

  validation {
    condition     = length(var.tags) != 0
    error_message = "We need tags!"
  }
}
