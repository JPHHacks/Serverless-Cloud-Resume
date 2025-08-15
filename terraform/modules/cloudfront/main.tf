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

  # NO logging_config block - this enables v2 logging
  # CloudFront v2 logging uses aws_cloudwatch_log_delivery resources instead

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

# CloudWatch Log Delivery Source for CloudFront (v2)
resource "aws_cloudwatch_log_delivery_source" "cloudfront_logs" {
  name         = "cloudwatch-access-logs-${var.environment}"
  log_type     = "ACCESS_LOGS"
  resource_arn = aws_cloudfront_distribution.distribution.arn
}

# CloudWatch Log Delivery Destination for CloudFront (v2)
resource "aws_cloudwatch_log_delivery_destination" "cloudfront_log_dest" {
  name           = "cloudfront-destination-logs-${var.environment}"
  output_format  = "json"  # Use JSON for easier querying
  
  delivery_destination_configuration {
    destination_resource_arn = aws_cloudwatch_log_group.cloudfront_logs.arn
  }
}

# CloudWatch Log Delivery for CloudFront (v2)
resource "aws_cloudwatch_log_delivery" "cloudfront_logs" {
  delivery_source_name      = aws_cloudwatch_log_delivery_source.cloudfront_logs.name
  delivery_destination_arn  = aws_cloudwatch_log_delivery_destination.cloudfront_log_dest.arn
  
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
