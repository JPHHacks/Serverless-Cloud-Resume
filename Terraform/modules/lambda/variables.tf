variable "function_name" {
  type        = string
  description = "The name of the Lambda function"
}

variable "environment" {
  type        = string
  description = "The environment (e.g., test, prod)"
}

variable "api_gateway_execution_arn" {
  type        = string
  description = "The execution ARN of the API Gateway"
}