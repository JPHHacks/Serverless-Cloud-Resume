# Enhanced CloudWatch Dashboard with CloudFront Logs
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
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/CloudFront", "4XXError", "DistributionId", var.cloudfront_distribution_id],
            [".", "5XXError", ".", "."]
          ]
          period = 300
          stat   = "Sum"
          region = "us-east-1"
          title  = "HTTP Error Rates (Security Monitoring)"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 6
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/CloudFront", "Requests", "DistributionId", var.cloudfront_distribution_id]
          ]
          period = 300
          stat   = "Sum"
          region = "us-east-1"
          title  = "Traffic Volume (DDoS Detection)"
        }
      },
      {
        type   = "log"
        x      = 0
        y      = 12
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

# Security Alarm - High Error Rate (Enhanced)
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

# Security Alarm - Site Down (Enhanced)
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

# Security Alarm - High 4XX Error Rate
resource "aws_cloudwatch_metric_alarm" "high_4xx_errors" {
  alarm_name          = "high-4xx-errors-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "4XXError"
  namespace           = "AWS/CloudFront"
  period              = "300"
  statistic           = "Sum"
  threshold           = "20"
  alarm_description   = "SECURITY ALERT: High 4XX error rate - potential scanning/attack"
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

# Security Alarm - Traffic Spike (DDoS Detection)
resource "aws_cloudwatch_metric_alarm" "traffic_spike" {
  alarm_name          = "traffic-spike-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "Requests"
  namespace           = "AWS/CloudFront"
  period              = "300"
  statistic           = "Sum"
  threshold           = "1000"
  alarm_description   = "SECURITY ALERT: Unusual traffic spike - potential DDoS"
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