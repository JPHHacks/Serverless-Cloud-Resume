resource "aws_route53_zone" "main" {
  name    = var.domain_name
  comment = "Hosted zone for ${var.domain_name}"
}

# Reference the existing Route 53 Hosted Zone
data "aws_route53_zone" "existing" {
  name = var.domain_name  
}

# Create A Record for the root domain pointing to CloudFront
resource "aws_route53_record" "root_alias" {
  zone_id = data.aws_route53_zone.existing.zone_id
  name     = var.domain_name  # Root domain (e.g., jpheymann.cloud)
  type     = "A"

  alias {
    name                   = var.cloudfront_domain_name  # CloudFront distribution domain name
    zone_id                = var.cloudfront_hosted_zone_id  # Hosted zone ID for CloudFront
    evaluate_target_health = true
  }
}

# Create A Record for the www subdomain pointing to CloudFront
resource "aws_route53_record" "www_alias" {
  zone_id = data.aws_route53_zone.existing.zone_id
  name     = "www.${var.domain_name}"  # Subdomain (e.g., www.jpheymann.cloud)
  type     = "A"

  alias {
    name                   = var.cloudfront_domain_name  # CloudFront distribution domain name
    zone_id                = var.cloudfront_hosted_zone_id  # Hosted zone ID for CloudFront
    evaluate_target_health = true
  }
}

# Create CNAME Record for another subdomain (e.g., blog)
resource "aws_route53_record" "blog_cname" {
  zone_id = data.aws_route53_zone.existing.zone_id
  name     = "blog.${var.domain_name}"  # Subdomain (e.g., blog.jpheymann.cloud)
  type     = "CNAME"

  ttl      = 300
  records   = [var.cloudfront_domain_name]  # CloudFront distribution domain name or another target
}
