output "api_gateway_url" {
  value       = aws_api_gateway_deployment.deployment.invoke_url
  description = "The URL of the API Gateway"
}

output "api_gateway_arn" {
  value       = aws_api_gateway_rest_api.website_view_counter_api.execution_arn
  description = "The ARN of the API Gateway"
}

output "api_gateway_execution_arn" {
  value       = aws_api_gateway_deployment.deployment.execution_arn
  description = "The execution ARN of the API Gateway deployment"
}