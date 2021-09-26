data "template_file" "web-userdata" {
  template = "${file("run.sh")}"
}

# Needed por ASG configuration
resource "aws_launch_configuration" "holded" {
  name          = "holded"
  image_id      = var.aws_image_id
  instance_type = var.aws_inst_type
  key_name = var.aws_key
  security_groups = [aws_security_group.ec2_sg.id]
  user_data = data.template_file.web-userdata.rendered
  iam_instance_profile = aws_iam_instance_profile.codeDeploy_profile
  # Ensure we have a launch configuration allways available 
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key                 = "Project"
    value               = "Holded"
  }
}

output "user_data" {
  value = data.template_file.web-userdata.rendered
}