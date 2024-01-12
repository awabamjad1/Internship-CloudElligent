resource "aws_lb" "default" {
  name            = "app-lb"
  subnets         = aws_subnet.public.*.id
  security_groups = [aws_security_group.lb.id]
}

resource "aws_lb_target_group" "ecs_lb_tg_sprint10" {
  name        = "ecstgsprint10"
  port        = 5000
  protocol    = "HTTP"
  vpc_id      = aws_vpc.default.id
  target_type = "instance"
}

resource "aws_lb_listener" "http_forward" {
  load_balancer_arn = aws_lb.default.id
  port              = "5000"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.ecs_lb_tg_sprint10.id
    type             = "forward"
  }
}