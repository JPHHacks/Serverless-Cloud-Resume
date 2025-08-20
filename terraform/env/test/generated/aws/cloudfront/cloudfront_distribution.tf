resource "aws_cloudfront_distribution" "tfer--E2QAT2VZ0RDLHY" {
  aliases = ["jpheymann.com", "www.jpheymann.com"]

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cache_policy_id        = "${aws_cloudfront_cache_policy.tfer--658327ea-f89d-4fab-a63d-7e88639e58f6.id}"
    cached_methods         = ["GET", "HEAD"]
    compress               = "true"
    default_ttl            = "0"
    max_ttl                = "0"
    min_ttl                = "0"
    smooth_streaming       = "false"
    target_origin_id       = "jpheymannweb.s3.us-east-1.amazonaws.com"
    viewer_protocol_policy = "redirect-to-https"
  }

  default_root_object = "index.html"
  enabled             = "true"
  http_version        = "http2"
  is_ipv6_enabled     = "true"

  origin {
    connection_attempts      = "3"
    connection_timeout       = "10"
    domain_name              = "jpheymannweb.s3.us-east-1.amazonaws.com"
    origin_id                = "jpheymannweb.s3.us-east-1.amazonaws.com"
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  retain_on_delete = "false"

  viewer_certificate {
    acm_certificate_arn            = "arn:aws:acm:us-east-1:329599633980:certificate/149278b9-28cf-44a2-9657-90344766365c"
    cloudfront_default_certificate = "false"
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }
}
