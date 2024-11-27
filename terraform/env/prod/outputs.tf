output "website_bucket_name" {
  description = "The name of the S3 bucket hosting the website"
  value       = module.s3_website.bucket_name
}

output "cloudfront_distribution_id" {
  description = "The ID of the CloudFront distribution"
  value       = module.cloudfront.distribution_id
}

output "cloudfront_distribution_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = module.cloudfront.distribution_domain_name
}

output "lambda_function_name" {
  description = "The name of the Lambda function"
  value       = module.lambda_function.function_name
}

output "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  value       = module.dynamodb.table_name
}

output "api_gateway_url" {
  description = "The URL of the API Gateway"
  value       = module.api_gateway.api_gateway_url
}

output "certificate_arn" {
  description = "The ARN of the SSL certificate"
  value       = module.certificate_manager.certificate_arn
}

output "route53_zone_id" {
  description = "The Zone ID of the Route53 hosted zone"
  value       = module.route53.route53_zone_id  
}