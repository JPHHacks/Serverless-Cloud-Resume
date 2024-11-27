resource "aws_acm_certificate" "cert" {
  domain_name               = var.domain_name
  subject_alternative_names = ["www.${var.domain_name}"]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Environment = var.environment
  }
}

# Create Route 53 records for validation
resource "aws_route53_record" "cert_validation" {
  for_each = { for o in aws_acm_certificate.cert.domain_validation_options : o.domain_name => o }

  name    = each.value.resource_record_name
  type    = each.value.resource_record_type
  zone_id = var.route53_zone_id
  records = [each.value.resource_record_value]
  ttl     = 60
}

# ACM certificate validation
resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}
