variable "table_name" {
  type        = string
  description = "The name of the DynamoDB table"
}

variable "environment" {
  type        = string
  description = "The environment (e.g., test, prod)"
}