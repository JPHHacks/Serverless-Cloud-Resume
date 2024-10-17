output "website_domain_record" {
  value       = aws_route53_record.website.fqdn
  description = "The fully qualified domain name of the website record"
}

output "cert_validation_record" {
  value       = aws_route53_record.cert_validation.fqdn
  description = "The fully qualified domain name of the certificate validation record"
}