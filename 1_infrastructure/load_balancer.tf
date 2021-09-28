data "aws_subnet_ids" "holded_subnets" {
  vpc_id = var.aws_vpc
}

resource "aws_lb_target_group" "holded_lb_target_group" {
  name     = "holded-lb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.aws_vpc
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 5
    timeout             = 3
    interval            = 60
    protocol            = "HTTP"
    port                = 80
    path                = "/health-check"
  }
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.holded.arn
  port              = "80"
  protocol          = "HTTP"

# Forward traffic to target group
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.holded_lb_target_group.arn
  }
}
resource "aws_lb" "holded" {
  name               = "holded"
  load_balancer_type = "application"
  subnets = data.aws_subnet_ids.holded_subnets.ids
  security_groups    = [aws_security_group.elb_sg.id]
}
