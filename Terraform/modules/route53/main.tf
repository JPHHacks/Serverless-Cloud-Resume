resource "aws_route53_record" "website" {
  zone_id = var.route53_zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "cert_validation" {
  name    = var.acm_certificate_domain_validation_options.resource_record_name
  type    = var.acm_certificate_domain_validation_options.resource_record_type
  zone_id = var.route53_zone_id
  records = [var.acm_certificate_domain_validation_options.resource_record_value]
  ttl     = 60
}