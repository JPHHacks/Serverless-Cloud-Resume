# Reference the existing Route 53 Hosted Zone
data "aws_route53_zone" "existing" {
  name = var.domain_name  
}

# Reference existing ACM certificate validation records
resource "aws_route53_record" "cert_validation" {
  count   = length(var.acm_certificate_domain_validation_options)  # Use the variable instead
  name    = var.acm_certificate_domain_validation_options[count.index].resource_record_name
  type    = var.acm_certificate_domain_validation_options[count.index].resource_record_type
  zone_id = data.aws_route53_zone.existing.zone_id
  records = [var.acm_certificate_domain_validation_options[count.index].resource_record_value]
  ttl     = 60
}

# Reference existing CNAME Record for ACM validation
resource "aws_route53_record" "acm_validation" {
  name    = "_8321e49a2bc104d624d1c47e8cc2e15a.${var.domain_name}"
  type    = "CNAME"
  zone_id = data.aws_route53_zone.existing.zone_id
  records = ["_a1d9e6b9c4d3cac343d832eea124ce33.djqtsrsxkq.acm-validations.aws."]
  ttl     = 300
}

# Reference existing A Record for the root domain
resource "aws_route53_record" "root" {
  name    = var.domain_name  
  type    = "A"
  zone_id = data.aws_route53_zone.existing.zone_id

  alias {
    evaluate_target_health = false
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_hosted_zone_id
  }
}

# Reference existing A Record for the www subdomain
resource "aws_route53_record" "www" {
  name    = "www.${var.domain_name}"  
  type    = "A"
  zone_id = data.aws_route53_zone.existing.zone_id

  alias {
    evaluate_target_health = false
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_hosted_zone_id
  }
}

# Reference existing NS Record
resource "aws_route53_record" "ns" {
  name    = var.domain_name  
  type    = "NS"
  zone_id = data.aws_route53_zone.existing.zone_id
  records = [
    "ns-125.awsdns-15.com.",
    "ns-1341.awsdns-39.org.",
    "ns-1721.awsdns-23.co.uk.",
    "ns-810.awsdns-37.net."
  ]
  ttl     = 172800
}

# Reference existing SOA Record
resource "aws_route53_record" "soa" {
  name    = var.domain_name  
  type    = "SOA"
  zone_id = data.aws_route53_zone.existing.zone_id
  records = [
    "ns-1341.awsdns-39.org. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"
  ]
  ttl     = 900
}