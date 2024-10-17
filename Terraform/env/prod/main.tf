module "s3_website" {
  source      = "../../modules/s3_website"
  bucket_name = "jpheymannweb"
  environment = "prod"
}

module "cloudfront" {
  source         = "../../modules/cloudfront"
  s3_bucket_name = module.s3_website.bucket_name
  aliases        = ["jpheymann.com", "www.jpheymann.com"]
  environment    = "prod"
}

module "lambda_function" {
  source        = "../../modules/lambda"
  function_name = "IncrementWebsiteViewCount"
  environment   = "prod"
}

module "dynamodb" {
  source      = "../../modules/dynamodb"
  table_name  = "ViewCount"
  environment = "prod"
}

module "api_gateway" {
  source               = "../../modules/api_gateway"
  environment          = "prod"
  lambda_function_name = module.lambda_function.function_name
  lambda_invoke_arn    = module.lambda_function.invoke_arn
}

module "certificate_manager" {
  source      = "../../modules/certificate_manager"
  domain_name = "jpheymann.com"
  environment = "prod"
}

module "route53" {
  source              = "../../modules/route53"
  domain_name         = "jpheymann.com"
  cloudfront_domain   = module.cloudfront.distribution_domain_name
  cloudfront_zone_id  = module.cloudfront.distribution_hosted_zone_id
  environment         = "prod"
}