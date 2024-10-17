output "bucket_name" {
  value       = aws_s3_bucket.website.id
  description = "The name of the S3 bucket"
}

output "bucket_arn" {
  value       = aws_s3_bucket.website.arn
  description = "The ARN of the S3 bucket"
}

output "bucket_regional_domain_name" {
  value       = aws_s3_bucket.website.bucket_regional_domain_name
  description = "The regional domain name of the S3 bucket"
}