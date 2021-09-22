resource "aws_autoscaling_group" "holded_asg" {
  name                 = "Holded asg"
  launch_configuration = aws_launch_configuration.holded.id
  target_group_arns    = [aws_lb_target_group.holded_lb_target_group.id]
  availability_zones   = var.aws_az
  # To ensure ELB is not failing
  health_check_grace_period = 300
  health_check_type         = "ELB"
  min_size             = 2
  max_size             = 5

  tag {
    key                 = "Project"
    value               = "holded"
    propagate_at_launch = true
  }
}