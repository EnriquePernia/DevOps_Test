# Create security group for our instances in ASG(Auto scaling group)
resource "aws_security_group" "backend_http" {
  name        = "Allow_holded_http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = var.aws_vpc

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http"
  }
}