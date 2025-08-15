# CloudFront Distribution
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

    # Uses the AWS managed CachingOptimized policy
    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"  # Managed CachingOptimized policy ID
  }

  # CloudFront Access Logging - Use existing S3 bucket
  logging_config {
    bucket          = data.aws_s3_bucket.logs_bucket.bucket_domain_name
    include_cookies = true
    prefix          = "cloudfront-logs/"
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

  # Ensure S3 logs bucket exists before CloudFront tries to use it
  depends_on = [
    data.aws_s3_bucket.logs_bucket
  ]
}

# Data source for S3 logs bucket
data "aws_s3_bucket" "logs_bucket" {
  bucket = "${var.s3_bucket_name}-logs"
}

# Origin Access Control for S3
resource "aws_cloudfront_origin_access_control" "default" {
  name                              = "OAC for ${var.s3_bucket_name}"
  description                       = "Origin Access Control for Cloud Resume Challenge"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
