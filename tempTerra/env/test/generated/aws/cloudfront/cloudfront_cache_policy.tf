resource "aws_cloudfront_cache_policy" "tfer--08627262-05a9-4f76-9ded-b50ca2e3a84f" {
  comment     = "Policy for Elemental MediaPackage Origin"
  default_ttl = "86400"
  max_ttl     = "31536000"
  min_ttl     = "0"
  name        = "Managed-Elemental-MediaPackage"

  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }

    enable_accept_encoding_brotli = "false"
    enable_accept_encoding_gzip   = "true"

    headers_config {
      header_behavior = "whitelist"

      headers {
        items = ["origin"]
      }
    }

    query_strings_config {
      query_string_behavior = "whitelist"

      query_strings {
        items = ["aws.manifestfilter", "end", "m", "start"]
      }
    }
  }
}

resource "aws_cloudfront_cache_policy" "tfer--1c6db51a-a33f-469a-8245-dae26771f530" {
  comment     = "Amplify cache policy for image optimization"
  default_ttl = "0"
  max_ttl     = "31536000"
  min_ttl     = "0"
  name        = "Managed-Amplify-ImageOptimization"

  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }

    enable_accept_encoding_brotli = "true"
    enable_accept_encoding_gzip   = "true"

    headers_config {
      header_behavior = "whitelist"

      headers {
        items = ["Accept", "Authorization", "Host"]
      }
    }

    query_strings_config {
      query_string_behavior = "all"
    }
  }
}

resource "aws_cloudfront_cache_policy" "tfer--2e54312d-136d-493c-8eb9-b001f22f67d2" {
  comment     = "Policy for Amplify Origin"
  default_ttl = "2"
  max_ttl     = "600"
  min_ttl     = "2"
  name        = "Managed-Amplify"

  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "all"
    }

    enable_accept_encoding_brotli = "true"
    enable_accept_encoding_gzip   = "true"

    headers_config {
      header_behavior = "whitelist"

      headers {
        items = ["Authorization", "CloudFront-Viewer-Country", "Host"]
      }
    }

    query_strings_config {
      query_string_behavior = "all"
    }
  }
}

resource "aws_cloudfront_cache_policy" "tfer--4135ea2d-6df8-44a3-9df3-4b5a84be39ad" {
  comment     = "Policy with caching disabled"
  default_ttl = "0"
  max_ttl     = "0"
  min_ttl     = "0"
  name        = "Managed-CachingDisabled"

  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }

    enable_accept_encoding_brotli = "false"
    enable_accept_encoding_gzip   = "false"

    headers_config {
      header_behavior = "none"
    }

    query_strings_config {
      query_string_behavior = "none"
    }
  }
}

resource "aws_cloudfront_cache_policy" "tfer--4cc15a8a-d715-48a4-82b8-cc0b614638fe" {
  comment     = "Policy for origins that return Cache-Control headers and serve different content based on values present in the query string."
  default_ttl = "0"
  max_ttl     = "31536000"
  min_ttl     = "0"
  name        = "UseOriginCacheControlHeaders-QueryStrings"

  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "all"
    }

    enable_accept_encoding_brotli = "true"
    enable_accept_encoding_gzip   = "true"

    headers_config {
      header_behavior = "whitelist"

      headers {
        items = ["host", "origin", "x-http-method", "x-http-method-override", "x-method-override"]
      }
    }

    query_strings_config {
      query_string_behavior = "all"
    }
  }
}

resource "aws_cloudfront_cache_policy" "tfer--4d1d2f1d-3a71-49ad-9e08-7ea5d843a556" {
  comment     = "Default Amplify cache policy"
  default_ttl = "0"
  max_ttl     = "31536000"
  min_ttl     = "0"
  name        = "Managed-Amplify-Default"

  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "all"
    }

    enable_accept_encoding_brotli = "true"
    enable_accept_encoding_gzip   = "true"

    headers_config {
      header_behavior = "whitelist"

      headers {
        items = ["Accept", "Authorization", "CloudFront-Viewer-Country", "Host"]
      }
    }

    query_strings_config {
      query_string_behavior = "all"
    }
  }
}

resource "aws_cloudfront_cache_policy" "tfer--658327ea-f89d-4fab-a63d-7e88639e58f6" {
  comment     = "Policy with caching enabled. Supports Gzip and Brotli compression."
  default_ttl = "86400"
  max_ttl     = "31536000"
  min_ttl     = "1"
  name        = "Managed-CachingOptimized"

  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }

    enable_accept_encoding_brotli = "true"
    enable_accept_encoding_gzip   = "true"

    headers_config {
      header_behavior = "none"
    }

    query_strings_config {
      query_string_behavior = "none"
    }
  }
}

resource "aws_cloudfront_cache_policy" "tfer--7e5fad67-ee98-4ad0-b05a-394999eefc1a" {
  comment     = "Amplify cache policy for static content"
  default_ttl = "0"
  max_ttl     = "31536000"
  min_ttl     = "0"
  name        = "Managed-Amplify-StaticContent"

  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }

    enable_accept_encoding_brotli = "true"
    enable_accept_encoding_gzip   = "true"

    headers_config {
      header_behavior = "whitelist"

      headers {
        items = ["Authorization", "Host"]
      }
    }

    query_strings_config {
      query_string_behavior = "none"
    }
  }
}

resource "aws_cloudfront_cache_policy" "tfer--83da9c7e-98b4-4e11-a168-04f0df8e2c65" {
  comment     = "Policy for origins that return Cache-Control headers. Query strings are not included in the cache key."
  default_ttl = "0"
  max_ttl     = "31536000"
  min_ttl     = "0"
  name        = "UseOriginCacheControlHeaders"

  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "all"
    }

    enable_accept_encoding_brotli = "true"
    enable_accept_encoding_gzip   = "true"

    headers_config {
      header_behavior = "whitelist"

      headers {
        items = ["host", "origin", "x-http-method", "x-http-method-override", "x-method-override"]
      }
    }

    query_strings_config {
      query_string_behavior = "none"
    }
  }
}

resource "aws_cloudfront_cache_policy" "tfer--a6bad946-36c3-4c33-aa98-362c74a7fb13" {
  comment     = "Default Amplify cache policy without cookies"
  default_ttl = "0"
  max_ttl     = "31536000"
  min_ttl     = "0"
  name        = "Managed-Amplify-DefaultNoCookies"

  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }

    enable_accept_encoding_brotli = "true"
    enable_accept_encoding_gzip   = "true"

    headers_config {
      header_behavior = "whitelist"

      headers {
        items = ["Accept", "Authorization", "CloudFront-Viewer-Country", "Host"]
      }
    }

    query_strings_config {
      query_string_behavior = "all"
    }
  }
}

resource "aws_cloudfront_cache_policy" "tfer--b2884449-e4de-46a7-ac36-70bc7f1ddd6d" {
  comment     = "Default policy when compression is disabled"
  default_ttl = "86400"
  max_ttl     = "31536000"
  min_ttl     = "1"
  name        = "Managed-CachingOptimizedForUncompressedObjects"

  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }

    enable_accept_encoding_brotli = "false"
    enable_accept_encoding_gzip   = "false"

    headers_config {
      header_behavior = "none"
    }

    query_strings_config {
      query_string_behavior = "none"
    }
  }
}
