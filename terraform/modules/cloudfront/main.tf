# CloudFront Cache Policy for Frequent Updates
resource "aws_cloudfront_cache_policy" "custom_cache_policy" {
  name = "CustomCachePolicy"

  default_ttl = 60  # 1 minute
  max_ttl     = 300  # 5 minutes
  min_ttl     = 0
  parameters_in_cache_key_and_forwarded_to_origin {
    enable_accept_encoding_brotli = true
    enable_accept_encoding_gzip = true
    
    cookies_config {
      cookie_behavior = "all"
    }
    
    headers_config {
      header_behavior = "whitelist"
      headers {
        items = ["Authorization"]
      }
    }
    
    query_strings_config {
      query_string_behavior = "all"
    }
  }
}

# CloudFront Distribution
resource "aws_cloudfront_distribution" "distribution" {
  enabled             = true
  is_ipv6_enabled     = true
  http_version        = "http2"
  default_root_object = "index.html"
  aliases             = var.aliases
  price_class         = "PriceClass_All"

  origin {
    domain_name              = "${var.s3_bucket_name}.s3.us-east-1.amazonaws.com"
    origin_id                = var.s3_bucket_name
    origin_access_control_id = aws_cloudfront_origin_access_control.default.id

    connection_attempts = 3
    connection_timeout  = 10
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = var.s3_bucket_name
    compress              = true
    viewer_protocol_policy = "redirect-to-https"

    # Use the custom cache policy
    cache_policy_id = aws_cloudfront_cache_policy.custom_cache_policy.id
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

# Origin Access Control for S3
resource "aws_cloudfront_origin_access_control" "default" {
  name                              = "OAC for ${var.s3_bucket_name}"
  description                       = "Origin Access Control for Cloud Resume Challenge"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
