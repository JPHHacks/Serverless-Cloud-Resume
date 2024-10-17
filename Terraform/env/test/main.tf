module "s3_website" {
  source      = "../../modules/s3_website"
  bucket_name = "jpheymannweb"
  environment = "test"
}

module "cloudfront" {
  source         = "../../modules/cloudfront"
  s3_bucket_name = module.s3_website.bucket_name
  aliases        = ["jpheymann.com", "www.jpheymann.com"]
  environment    = "test"
}

module "lambda_function" {
  source        = "../../modules/lambda"
  function_name = "IncrementWebsiteViewCount"
  environment   = "test"
}

module "dynamodb" {
  source      = "../../modules/dynamodb"
  table_name  = "ViewCount"
  environment = "test"
}

module "api_gateway" {
  source               = "../../modules/api_gateway"
  environment          = "test"
  lambda_function_name = module.lambda_function.function_name
  lambda_invoke_arn    = module.lambda_function.invoke_arn
}

# If you're using ACM for SSL certificates
module "certificate_manager" {
  source      = "../../modules/certificate_manager"
  domain_name = "jpheymann.com"
  environment = "test"
}

# If you're managing Route53 records
module "route53" {
  source              = "../../modules/route53"
  domain_name         = "jpheymann.com"
  cloudfront_domain   = module.cloudfront.distribution_domain_name
  cloudfront_zone_id  = module.cloudfront.distribution_hosted_zone_id
  environment         = "test"
}