variable "environment" {
  type        = string
  description = "The environment (e.g., test, prod)"
}

variable "lambda_function_name" {
  type        = string
  description = "The name of the Lambda function to integrate with"
}

variable "lambda_invoke_arn" {
  type        = string
  description = "The ARN to invoke the Lambda function"
}