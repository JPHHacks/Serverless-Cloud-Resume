variable "route53_zone_id" {
  type        = string
  description = "The ID of the Route 53 hosted zone"
}

variable "domain_name" {
  type        = string
  description = "The domain name for the website"
}

variable "cloudfront_domain_name" {
  type        = string
  description = "The domain name of the CloudFront distribution"
}

variable "cloudfront_hosted_zone_id" {
  type        = string
  description = "The hosted zone ID of the CloudFront distribution"
}

variable "acm_certificate_domain_validation_options" {
  type = object({
    resource_record_name  = string
    resource_record_type  = string
    resource_record_value = string
  })
  description = "The domain validation options for the ACM certificate"
}

variable "environment" {
  type        = string
  description = "The environment (e.g., test, prod)"
}