variable "environment" {
  description = "Environment name"
  type        = string
}

variable "email_address" {
  description = "Email address for security alerts"
  type        = string
  default     = null
} 