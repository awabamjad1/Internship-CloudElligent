resource "aws_cloudwatch_metric_alarm" "cpu_utilization_alarm" {
  alarm_name          = "CPUUtilizationHigh"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"  # 5 minutes
  statistic           = "Average"
  threshold           = "50"  

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.sample.name
  }

  alarm_description = "Alarm for scaling up when CPU utilization is high"
  alarm_actions     = [aws_autoscaling_policy.scale_out.arn]
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_low_alarm" {
  alarm_name          = "CPUUtilizationLow"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"  # 5 minutes
  statistic           = "Average"
  threshold           = "30"  

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.sample.name
  }

  alarm_description = "Alarm for scaling down when CPU utilization is low"
  alarm_actions     = [aws_autoscaling_policy.scale_in.arn]
}