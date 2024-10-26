resource "aws_s3_bucket" "tfer--jpheymannweb" {
  bucket        = "jpheymannweb"
  force_destroy = false

  object_lock_enabled = false

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowCloudFrontServicePrincipalReadOnly"
        Effect    = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "arn:aws:s3:::jpheymannweb/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = "arn:aws:cloudfront::329599633980:distribution/E2QAT2VZ0RDLHY"
          }
        }
      }
    ]
  })

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = true
    }
  }

  versioning {
    enabled    = true
    mfa_delete = false
  }

  tags = {
    Environment = "test"  # Assuming this is for the test environment
  }
}