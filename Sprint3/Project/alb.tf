resource "aws_lb" "this" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = module.vpc.public_subnets
  security_groups    = [aws_security_group.ec2.id]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
resource "aws_lb_listener" "port80" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.port80.arn
  }
}

resource "aws_lb_target_group" "port80" {
  name        = "forport80"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  target_type = "instance"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_lb_target_group_attachment" "ec2_port_80" {
  count             = 2
  target_group_arn  = aws_lb_target_group.port80.arn
  target_id         = module.ec2_instance[count.index].id
  port              = 80
}

resource "aws_lb_listener" "port5000" {
  load_balancer_arn = aws_lb.this.arn
  port              = 5000
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.port5000.arn
  }
}

resource "aws_lb_target_group" "port5000" {
  name        = "forport5000"
  port        = 5000
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  target_type = "instance"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_lb_target_group_attachment" "ec2_port_5000" {
  count             = 2
  target_group_arn  = aws_lb_target_group.port5000.arn
  target_id         = module.ec2_instance[count.index].id
  port              = 5000
}