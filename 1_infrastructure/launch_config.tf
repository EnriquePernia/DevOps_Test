# Needed por ASG configuration
resource "aws_launch_configuration" "holded" {
  name          = "holded"
  image_id      = "ami-58d7e821"
  instance_type = "t2.micro"

  security_groups = ["${aws_security_group.ec2_sg.id}"]

  user_data = "./run.sh"

  # Ensure we have a launch configuration allways available 
  lifecycle {
    create_before_destroy = true
  }
}