resource "aws_codedeploy_app" "holded_app" {
  name             = "holded_app"
}

resource "aws_codedeploy_deployment_group" "holded" {
  app_name              = aws_codedeploy_app.holded_app.name
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
  deployment_group_name = "holded_group"
  service_role_arn      = aws_iam_role.codeDeploy_role.arn
  # Link it with the ASG we deployed
  autoscaling_groups = [ aws_autoscaling_group.holded_asg.name ]
}