# Create security group for our instances in ASG (Auto scaling group)
resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "Allow HTTP inbound traffic"
  vpc_id      = var.aws_vpc

  ingress {
    security_groups = [ aws_security_group.elb_sg.id ] # To only be accesible from load balancer
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "ec2_sg"
  }
}

# Create security group for ELB (Elastic load balancer)
resource "aws_security_group" "elb_sg" {
  name = "lb_sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "lb_sg"
  }
}