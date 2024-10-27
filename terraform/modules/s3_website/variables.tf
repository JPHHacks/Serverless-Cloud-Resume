variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket"
}

variable "environment" {
  type        = string
  description = "The environment (e.g., test, prod)"
}

variable "cloudfront_distribution_arn" {
  type        = string
  description = "The ARN of the CloudFront distribution"
}