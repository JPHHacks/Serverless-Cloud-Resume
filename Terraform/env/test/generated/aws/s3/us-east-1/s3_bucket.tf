resource "aws_s3_bucket" "tfer--jpheymannweb" {
  bucket        = "jpheymannweb"
  force_destroy = "false"

  grant {
    id          = "d37331fd83a66230509899794c32ffa173a91098698c574da5b1c0e5137da372"
    permissions = ["FULL_CONTROL"]
    type        = "CanonicalUser"
  }

  object_lock_enabled = "false"

  policy = <<POLICY
{
  "Id": "PolicyForCloudFrontPrivateContent",
  "Statement": [
    {
      "Action": "s3:GetObject",
      "Condition": {
        "StringEquals": {
          "AWS:SourceArn": "arn:aws:cloudfront::329599633980:distribution/E2QAT2VZ0RDLHY"
        }
      },
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudfront.amazonaws.com"
      },
      "Resource": "arn:aws:s3:::jpheymannweb/*",
      "Sid": "AllowCloudFrontServicePrincipal"
    }
  ],
  "Version": "2008-10-17"
}
POLICY

  request_payer = "BucketOwner"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }

      bucket_key_enabled = "true"
    }
  }

  versioning {
    enabled    = "true"
    mfa_delete = "false"
  }
}
