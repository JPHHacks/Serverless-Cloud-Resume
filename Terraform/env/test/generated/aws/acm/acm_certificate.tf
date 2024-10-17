resource "aws_acm_certificate" "tfer--149278b9-28cf-44a2-9657-90344766365c_jpheymann-002E-com" {
  domain_name   = "jpheymann.com"
  key_algorithm = "RSA_2048"

  options {
    certificate_transparency_logging_preference = "ENABLED"
  }

  subject_alternative_names = ["*.jpheymann.com", "jpheymann.com"]
  validation_method         = "DNS"
}
