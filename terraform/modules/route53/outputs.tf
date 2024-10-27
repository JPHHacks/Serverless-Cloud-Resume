output "website_domain_record" {
  value       = aws_route53_record.root.fqdn
  description = "The fully qualified domain name of the website record"
}

output "cert_validation_record" {
  value       = aws_route53_record.cert_validation.fqdn
  description = "The fully qualified domain name of the certificate validation record"
}

output "route53_zone_id" {
  value       = data.aws_route53_zone.existing.zone_id
  description = "The ID of the Route 53 hosted zone"
}