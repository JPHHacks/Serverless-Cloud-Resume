output "table_name" {
  value       = aws_dynamodb_table.website_view_counter.name
  description = "The name of the DynamoDB table"
}

output "table_arn" {
  value       = aws_dynamodb_table.website_view_counter.arn
  description = "The ARN of the DynamoDB table"
}