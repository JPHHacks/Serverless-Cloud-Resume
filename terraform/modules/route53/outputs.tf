output "website_domain_record" {
  value       = aws_route53_record.root.fqdn
  description = "The fully qualified domain name of the website record"
}

output "cert_validation_record" {
  value       = [for record in aws_route53_record.cert_validation : record.fqdn]  # Output all FQDNs as a list
  description = "The fully qualified domain names of the certificate validation records"
}

output "route53_zone_id" {
  value       = data.aws_route53_zone.existing.zone_id
  description = "The ID of the Route 53 hosted zone"
}