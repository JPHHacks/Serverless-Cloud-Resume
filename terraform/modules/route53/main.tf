# References the existing Route 53 Hosted Zone
data "aws_route53_zone" "existing" {
  name = var.domain_name  
}

# Creates A Record for the root domain pointing to CloudFront
resource "aws_route53_record" "root_alias" {
  zone_id = data.aws_route53_zone.existing.zone_id
  name     = var.domain_name  # Root domain 
  type     = "A"

  alias {
    name                   = var.cloudfront_domain_name  # CloudFront distribution domain name
    zone_id                = var.cloudfront_hosted_zone_id  # Hosted zone ID for CloudFront
    evaluate_target_health = true
  }
}

# Creates A Record for the www subdomain pointing to CloudFront
resource "aws_route53_record" "www_alias" {
  zone_id = data.aws_route53_zone.existing.zone_id
  name     = "www.${var.domain_name}"  # Subdomain 
  type     = "A"

  alias {
    name                   = var.cloudfront_domain_name  # CloudFront distribution domain name
    zone_id                = var.cloudfront_hosted_zone_id  # Hosted zone ID for CloudFront
    evaluate_target_health = true
  }
}

