# CloudWatch Dashboard - Security Monitoring
resource "aws_cloudwatch_dashboard" "security" {
  dashboard_name = "security-dashboard-${var.environment}"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/CloudFront", "Requests", "DistributionId", var.cloudfront_distribution_id],
            [".", "5XXError", ".", "."]
          ]
          period = 300
          stat   = "Sum"
          region = "us-east-1"
          title  = "Website Traffic & Errors"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/CloudFront", "TotalErrorRate", "DistributionId", var.cloudfront_distribution_id]
          ]
          period = 300
          stat   = "Average"
          region = "us-east-1"
          title  = "Error Rate (Security Indicator)"
        }
      },
      {
        type   = "log"
        x      = 0
        y      = 6
        width  = 24
        height = 6

        properties = {
          query   = "SOURCE '/aws/cloudfront/${var.environment}' | fields @timestamp, @message | filter @message like /ERROR|4XX|5XX/ | sort @timestamp desc | limit 20"
          region  = "us-east-1"
          title   = "Real-Time CloudFront Logs (Security Events)"
        }
      }
    ]
  })
}

# CloudWatch Logs Insights Query for Security
resource "aws_cloudwatch_query_definition" "security_events" {
  name = "security-events-${var.environment}"

  log_group_names = ["/aws/cloudfront/${var.environment}"]

  query_string = <<EOF
fields @timestamp, @message
| filter @message like /ERROR|4XX|5XX|Unauthorized|AccessDenied/
| sort @timestamp desc
| limit 100
EOF
}

# Security Alarm - High Error Rate
resource "aws_cloudwatch_metric_alarm" "security_error_rate" {
  alarm_name          = "security-error-rate-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "5XXError"
  namespace           = "AWS/CloudFront"
  period              = "300"
  statistic           = "Sum"
  threshold           = "10"
  alarm_description   = "SECURITY ALERT: High error rate - potential attack"
  alarm_actions       = var.sns_topic_arn != null ? [var.sns_topic_arn] : []

  dimensions = {
    DistributionId = var.cloudfront_distribution_id
    Region         = "Global"
  }

  tags = {
    Environment = var.environment
    Security    = "true"
  }
}

# Security Alarm - No Traffic (Site Down)
resource "aws_cloudwatch_metric_alarm" "site_down" {
  alarm_name          = "site-down-${var.environment}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "3"
  metric_name         = "Requests"
  namespace           = "AWS/CloudFront"
  period              = "300"
  statistic           = "Sum"
  threshold           = "1"
  alarm_description   = "SECURITY ALERT: Site down - potential security incident"
  alarm_actions       = var.sns_topic_arn != null ? [var.sns_topic_arn] : []

  dimensions = {
    DistributionId = var.cloudfront_distribution_id
    Region         = "Global"
  }

  tags = {
    Environment = var.environment
    Security    = "true"
  }
}

# Cost Protection Alarm for CloudWatch Logs
resource "aws_cloudwatch_metric_alarm" "logs_cost_protection" {
  alarm_name          = "logs-cost-protection-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "IncomingLogEvents"
  namespace           = "AWS/Logs"
  period              = "86400"  # Daily
  statistic           = "Sum"
  threshold           = "500000"  # Alert at 500K events/day
  alarm_description   = "CloudWatch Logs usage approaching free tier limit"
  alarm_actions       = var.sns_topic_arn != null ? [var.sns_topic_arn] : []

  tags = {
    Environment = var.environment
    Purpose     = "Cost protection"
  }
} 