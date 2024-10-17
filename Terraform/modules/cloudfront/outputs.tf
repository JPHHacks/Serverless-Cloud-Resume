output "distribution_id" {
  value       = aws_cloudfront_distribution.distribution.id
  description = "The ID of the CloudFront distribution"
}

output "distribution_domain_name" {
  value       = aws_cloudfront_distribution.distribution.domain_name
  description = "The domain name of the CloudFront distribution"
}

output "distribution_hosted_zone_id" {
  value       = aws_cloudfront_distribution.distribution.hosted_zone_id
  description = "The CloudFront distribution hosted zone ID"
}