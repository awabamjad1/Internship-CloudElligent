resource "aws_autoscaling_policy" "scale_out" {
  name                   = "scale-out-policy"
  scaling_adjustment      = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300  # 5 minutes cooldown period
  autoscaling_group_name = aws_autoscaling_group.sample.name
}

resource "aws_autoscaling_policy" "scale_in" {
  name                   = "scale-in-policy"
  scaling_adjustment      = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300  # 5 minutes cooldown period
  autoscaling_group_name = aws_autoscaling_group.sample.name
}