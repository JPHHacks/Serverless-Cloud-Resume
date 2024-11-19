
output "route53_zone_id" {
  value       = data.aws_route53_zone.existing.zone_id
  description = "The ID of the Route 53 hosted zone"
}

# Output the FQDN of the root domain
output "root_domain_record" {
  value       = aws_route53_record.root_alias.fqdn  # Reference the root alias record
  description = "The fully qualified domain name of the root domain"
}

# Output the FQDN of the www subdomain
output "www_domain_record" {
  value       = aws_route53_record.www_alias.fqdn  # Reference the www alias record
  description = "The fully qualified domain name of the www subdomain"
}

# Output the FQDN of the blog subdomain
output "blog_domain_record" {
  value       = aws_route53_record.blog_cname.fqdn  # Reference the blog CNAME record
  description = "The fully qualified domain name of the blog subdomain"
}