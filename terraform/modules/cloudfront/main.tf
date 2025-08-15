# CloudFront Distribution with CloudWatch Logs v2
resource "aws_cloudfront_distribution" "distribution" {
  enabled             = true
  is_ipv6_enabled     = true
  http_version        = "http2"
  default_root_object = "index.html"
  aliases             = var.aliases
  price_class         = "PriceClass_All"

  origin {
    domain_name = "${var.s3_bucket_name}.s3.us-east-1.amazonaws.com"
    origin_id   = var.s3_bucket_name

    connection_attempts = 3
    connection_timeout  = 10
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = var.s3_bucket_name
    compress              = true
    viewer_protocol_policy = "redirect-to-https"

    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
  }

  # CloudWatch Logs v2 integration
  logging_config {
    bucket          = null  # Not using S3
    include_cookies = true
    prefix          = null  # Not using S3
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.certificate_arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }

  tags = {
    Environment = var.environment
  }
}

# CloudWatch Log Group for CloudFront
resource "aws_cloudwatch_log_group" "cloudfront_logs" {
  name              = "/aws/cloudfront/${var.environment}"
  retention_in_days = 30

  tags = {
    Environment = var.environment
    Purpose     = "CloudFront access logs"
  }
}

# CloudWatch Log Delivery Source for CloudFront
resource "aws_cloudwatch_log_delivery_source" "cloudfront" {
  name = "cloudfront-logs-${var.environment}"
  
  log_delivery_source_type = "CloudFront"
  
  tags = {
    Environment = var.environment
    Purpose     = "CloudFront logs delivery source"
  }
}

# CloudWatch Log Delivery for CloudFront
resource "aws_cloudwatch_log_delivery" "cloudfront" {
  name = "cloudfront-logs-${var.environment}"
  
  log_delivery_source_name = aws_cloudwatch_log_delivery_source.cloudfront.name
  
  log_group_name = aws_cloudwatch_log_group.cloudfront_logs.name
  
  log_type = "ACCESS_LOGS"
  
  tags = {
    Environment = var.environment
    Purpose     = "CloudFront access logs delivery"
  }
}

# Origin Access Control for S3
resource "aws_cloudfront_origin_access_control" "default" {
  name                              = "OAC for ${var.s3_bucket_name}"
  description                       = "Origin Access Control for Cloud Resume Challenge"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
