variable "s3_bucket_name" {
  type        = string
  description = "The name of the S3 bucket for the website"
}

variable "s3_bucket_arn" {
  type        = string
  description = "The ARN of the S3 bucket for the website"
}

variable "aliases" {
  type        = list(string)
  description = "List of aliases (domain names) for the CloudFront distribution"
}

variable "environment" {
  type        = string
  description = "The environment (e.g., test, prod)"
}

variable "certificate_arn" {
  type        = string
  description = "The ARN of the ACM certificate to use for CloudFront"
}