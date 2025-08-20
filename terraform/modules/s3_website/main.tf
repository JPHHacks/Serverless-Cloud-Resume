# Data source to get CloudFront distribution details
data "aws_cloudfront_distribution" "distribution" {
  id = var.cloudfront_distribution_id
}

resource "aws_s3_bucket" "website_bucket" {
  bucket        = var.bucket_name
  force_destroy = false

  tags = {
    Environment = var.environment
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "website_bucket_encryption" {
  bucket = aws_s3_bucket.website_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "website_bucket_versioning" {
  bucket = aws_s3_bucket.website_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website_bucket.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Id": "PolicyForCloudFrontPrivateContent",
    "Statement": [
        {
            "Sid": "AllowCloudFrontServicePrincipal",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudfront.amazonaws.com"
            },
            "Action": "s3:GetObject",
            "Resource": "${aws_s3_bucket.website_bucket.arn}/*",
            "Condition": {
                "StringEquals": {
                    "AWS:SourceArn": data.aws_cloudfront_distribution.distribution.arn
                }
            }
        }
    ]
  })
}

resource "aws_s3_bucket_public_access_block" "website" {
  bucket = aws_s3_bucket.website_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}