variable "environment" {
  type        = string
  description = "The environment (test or prod)"
  default     = "test"
}

variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket for the website"
  default     = "jpheymannweb"
}

variable "domain_name" {
  type        = string
  description = "The domain name for the website"
  default     = "jpheymann.com"
}

variable "lambda_function_name" {
  type        = string
  description = "The name of the Lambda function"
  default     = "IncrementWebsiteViewCount"
}

variable "dynamodb_table_name" {
  type        = string
  description = "The name of the DynamoDB table"
  default     = "ViewCount"
}