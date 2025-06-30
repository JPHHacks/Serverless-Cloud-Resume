output "topic_arn" {
  description = "SNS topic ARN for security alerts"
  value       = aws_sns_topic.security_alerts.arn
}

output "topic_name" {
  description = "SNS topic name"
  value       = aws_sns_topic.security_alerts.name
} 