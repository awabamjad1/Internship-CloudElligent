resource "aws_lb" "this" {
  name               = "alb"
  internal           = false # Set to false for external (internet-facing) ALB
  load_balancer_type = "application"
  subnets            = module.vpc.public_subnets
  security_groups    = [aws_security_group.wordreversal_ecs_sg.id]

  tags = {
    Owner = "Awab"
    Name = "alb-awab"
  }
}
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
# Specifying target group for listner on port 80
resource "aws_lb_target_group" "this" {
  name        = "flaskify-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.vpc.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-299"
    interval            = "300"
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
  tags = {
    Owner = "Awab"
  }
}



