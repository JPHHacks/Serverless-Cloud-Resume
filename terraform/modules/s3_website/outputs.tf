output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.website_bucket.bucket
}

output "bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.website_bucket.arn
}

output "bucket_domain_name" {
  description = "Domain name of the S3 bucket"
  value       = aws_s3_bucket.website_bucket.bucket_domain_name
}

output "logs_bucket_arn" {
  description = "ARN of the S3 logs bucket"
  value       = aws_s3_bucket.logs_bucket.arn
}