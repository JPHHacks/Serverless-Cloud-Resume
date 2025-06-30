variable "environment" {
  description = "Environment name"
  type        = string
}

variable "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  type        = string
}

variable "sns_topic_arn" {
  description = "SNS topic ARN for security alerts"
  type        = string
  default     = null
} 