resource "aws_ecs_cluster" "this" {
  name = "app-cluster"
}

resource "aws_ecs_task_definition" "task_definition" {
  family = "backend"
  container_definitions = templatefile("task-definitions/service.json.tpl", {
    aws_cloudwatch_log_group = aws_cloudwatch_log_group.ecs.name
  })
  requires_compatibilities = ["EC2"]
}

resource "aws_ecs_service" "frontend" {
  name            = "backend"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  launch_type     = "EC2"
  desired_count   = 1

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs_lb_tg_sprint10.arn
    container_name   = "backend"
    container_port   = 5000
  }

  depends_on = [aws_lb_listener.http_forward]

  tags = local.tags
}