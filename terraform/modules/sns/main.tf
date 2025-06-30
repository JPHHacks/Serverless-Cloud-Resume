# SNS Topic for Security Alerts
resource "aws_sns_topic" "security_alerts" {
  name = "security-alerts-${var.environment}"

  tags = {
    Environment = var.environment
    Purpose     = "Security incident notifications"
  }
}

# SNS Topic Policy
resource "aws_sns_topic_policy" "security_alerts" {
  arn = aws_sns_topic.security_alerts.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "cloudwatch.amazonaws.com"
        }
        Action = [
          "SNS:Publish"
        ]
        Resource = aws_sns_topic.security_alerts.arn
      }
    ]
  })
}

# SNS Subscription - Email Alerts
resource "aws_sns_topic_subscription" "security_email" {
  count     = var.email_address != null ? 1 : 0
  topic_arn = aws_sns_topic.security_alerts.arn
  protocol  = "email"
  endpoint  = var.email_address
} 