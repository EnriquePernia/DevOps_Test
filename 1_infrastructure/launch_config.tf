data "template_file" "web-userdata" {
  template = "${file("run.sh")}"
}

# Needed por ASG configuration
resource "aws_launch_configuration" "holded" {
  name          = "holded"
  image_id      = "ami-0d1bf5b68307103c2"
  instance_type = "t2.micro"
  key_name = var.aws_key
  security_groups = ["sg-0663de3e394f4149c"]
  user_data = data.template_file.web-userdata.rendered

  # Ensure we have a launch configuration allways available 
  lifecycle {
    create_before_destroy = true
  }
}

output "user_data" {
  value = data.template_file.web-userdata.rendered
}