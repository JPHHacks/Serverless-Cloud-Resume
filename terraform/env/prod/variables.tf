variable "environment" {
  type        = string
  description = "The environment (test or prod)"
  default     = "prod"
}

variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket for the website"
  default     = "jpheymannweb-prod"
}

variable "domain_name" {
  type        = string
  description = "The domain name for the website"
  default     = "jpheymann.cloud"
}

variable "lambda_function_name" {
  type        = string
  description = "The name of the Lambda function"
  default     = "IncrementWebsiteViewCount"
}

variable "dynamodb_table_name" {
  type        = string
  description = "The name of the DynamoDB table"
  default     = "WebsiteViewCounter"
}

variable "route53_zone_name" {
  description = "The name of the Route 53 hosted zone"
  type        = string
  default     = "jpheymann.cloud"
}