locals {
  tmp_dvo = var.for_cloudfront ? aws_acm_certificate.cert_cloudfront[0].domain_validation_options : aws_acm_certificate.cert[0].domain_validation_options

  domain_validation_options = {
    for dvo in local.tmp_dvo : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  validation_record_fqdns = [for record in aws_route53_record.cert_validations : record.fqdn]
}

resource "aws_acm_certificate" "cert" {
  count = var.for_cloudfront ? 0 : 1

  domain_name               = var.domain_name
  subject_alternative_names = var.sans
  validation_method         = "DNS"

  tags = var.tags
}

resource "aws_acm_certificate" "cert_cloudfront" {
  count = var.for_cloudfront ? 1 : 0

  provider = aws.us_east_1

  domain_name               = var.domain_name
  subject_alternative_names = var.sans
  validation_method         = "DNS"

  tags = var.tags
}

resource "aws_route53_record" "cert_validations" {
  for_each = local.domain_validation_options

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.route53_zone_id
}

resource "aws_acm_certificate_validation" "cert" {
  count = var.for_cloudfront ? 0 : 1

  certificate_arn         = aws_acm_certificate.cert[0].arn
  validation_record_fqdns = local.validation_record_fqdns
}

resource "aws_acm_certificate_validation" "cert_cloudfront" {
  count = var.for_cloudfront ? 1 : 0

  provider = aws.us_east_1

  certificate_arn         = aws_acm_certificate.cert_cloudfront[0].arn
  validation_record_fqdns = local.validation_record_fqdns
}

