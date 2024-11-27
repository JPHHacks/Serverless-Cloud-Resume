
output "route53_zone_id" {
  value       = data.aws_route53_zone.existing.zone_id
  description = "The ID of the Route 53 hosted zone"
}

# Outputs the FQDN of the root domain
output "root_domain_record" {
  value       = aws_route53_record.root_alias.fqdn  # References the root alias record
  description = "The fully qualified domain name of the root domain"
}

# Outputs the FQDN of the www subdomain
output "www_domain_record" {
  value       = aws_route53_record.www_alias.fqdn  # References the www alias record
  description = "The fully qualified domain name of the www subdomain"
}

