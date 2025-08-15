output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.website_bucket.id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.website_bucket.arn
}

output "bucket_regional_domain_name" {
  description = "The regional domain name of the S3 bucket, used for CloudFront origin"
  value       = aws_s3_bucket.website_bucket.bucket_regional_domain_name
}

output "logs_bucket_arn" {
  description = "The ARN of the S3 logs bucket for CloudFront access logs"
  value       = aws_s3_bucket.logs_bucket.arn
}