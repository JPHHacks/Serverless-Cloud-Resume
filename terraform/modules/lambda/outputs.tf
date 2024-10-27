output "function_name" {
  value       = aws_lambda_function.website_view_counter.function_name
  description = "The name of the Lambda function"
}

output "function_arn" {
  value       = aws_lambda_function.website_view_counter.arn
  description = "The ARN of the Lambda function"
}

output "invoke_arn" {
  value       = aws_lambda_function.website_view_counter.invoke_arn
  description = "The invoke ARN of the Lambda function"
}