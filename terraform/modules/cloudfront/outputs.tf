output "distribution_id" {
  description = "CloudFront distribution ID"
  value       = aws_cloudfront_distribution.distribution.id
}

output "distribution_domain_name" {
  description = "CloudFront distribution domain name"
  value       = aws_cloudfront_distribution.distribution.domain_name
}

output "distribution_hosted_zone_id" {
  description = "CloudFront distribution hosted zone ID"
  value       = aws_cloudfront_distribution.distribution.hosted_zone_id
}

output "distribution_arn" {
  description = "CloudFront distribution ARN"
  value       = aws_cloudfront_distribution.distribution.arn
}

output "access_logs_bucket" {
  description = "S3 bucket name for CloudFront access logs"
  value       = aws_s3_bucket.access_logs.bucket
}

output "access_logs_bucket_arn" {
  description = "S3 bucket ARN for CloudFront access logs"
  value       = aws_s3_bucket.access_logs.arn
}