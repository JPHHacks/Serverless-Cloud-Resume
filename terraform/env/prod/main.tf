data "aws_route53_zone" "existing" {
  name = var.domain_name  
}

# S3 Website Module
module "s3_website" {
  source                     = "../../modules/s3_website"
  bucket_name                = var.bucket_name
  environment                = var.environment
  cloudfront_distribution_arn = module.cloudfront.distribution_arn
}

# Route53 Module
module "route53" {
  source                             = "../../modules/route53"
  domain_name                        = var.domain_name
  cloudfront_domain_name             = module.cloudfront.distribution_domain_name
  cloudfront_hosted_zone_id          = module.cloudfront.distribution_hosted_zone_id
  environment                        = var.environment
  acm_certificate_domain_validation_options = module.certificate_manager.domain_validation_options  # Pass the validation options
  route53_zone_id                   = data.aws_route53_zone.existing.zone_id
  route53_zone_name                 = var.route53_zone_name
}

# Certificate Manager Module
module "certificate_manager" {
  source         = "../../modules/certificate_manager"
  domain_name    = var.domain_name
  environment    = var.environment
  route53_zone_id = module.route53.route53_zone_id 
 }

# CloudFront Module
  module "cloudfront" {
  source         = "../../modules/cloudfront"
  s3_bucket_name = module.s3_website.bucket_name
  s3_bucket_arn  = module.s3_website.bucket_arn
  aliases        = [var.domain_name, "www.${var.domain_name}"]
  environment    = var.environment
  certificate_arn = module.certificate_manager.certificate_arn
}

# Lambda Function Module
module "lambda_function" {
  source        = "../../modules/lambda"
  function_name = var.lambda_function_name
  environment   = var.environment
  api_gateway_execution_arn = module.api_gateway.api_gateway_execution_arn
}

# DynamoDB Module
module "dynamodb" {
  source      = "../../modules/dynamodb"
  table_name  = var.dynamodb_table_name
  environment = var.environment
}

# API Gateway Module
module "api_gateway" {
  source               = "../../modules/api_gateway"
  environment          = var.environment
  lambda_function_name = module.lambda_function.function_name
  lambda_invoke_arn    = module.lambda_function.invoke_arn
}