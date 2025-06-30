output "dashboard_name" {
  description = "Security dashboard name"
  value       = aws_cloudwatch_dashboard.security.dashboard_name
}

output "error_alarm_name" {
  description = "Security error rate alarm name"
  value       = aws_cloudwatch_metric_alarm.security_error_rate.alarm_name
}

output "site_down_alarm_name" {
  description = "Site down alarm name"
  value       = aws_cloudwatch_metric_alarm.site_down.alarm_name
} 