resource "aws_acm_certificate" "cert" {
  provider = aws.us_east_1

  domain_name               = var.domain_name
  subject_alternative_names = var.sans
  validation_method         = "DNS"

  tags = var.tags
}

data "aws_route53_zone" "zone" {
  name = var.route53_zone_name
}

resource "aws_route53_record" "cert_validation" {
  name    = aws_acm_certificate.cert.domain_validation_options.0.resource_record_name
  records = [aws_acm_certificate.cert.domain_validation_options.0.resource_record_value]
  ttl     = 60
  type    = aws_acm_certificate.cert.domain_validation_options.0.resource_record_type
  zone_id = data.aws_route53_zone.zone.zone_id
}

resource "aws_acm_certificate_validation" "cert" {
  provider = aws.us_east_1

  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}
