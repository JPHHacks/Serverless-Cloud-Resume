variable "domain_name" {
  type        = string
  description = "The domain name for the certificate"
}

variable "environment" {
  type        = string
  description = "The environment (e.g., test, prod)"
}

variable "route53_zone_id" {
  type        = string
  description = "The Route53 zone ID for DNS validation"
}