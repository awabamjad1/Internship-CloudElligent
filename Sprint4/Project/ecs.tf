resource "aws_ecs_cluster" "this" {
  name = "wordreversal"
  tags = {
    Name ="wordreversal-awab"
    Owner = "Awab"
  }

}
resource "aws_ecs_service" "this" {
    name = "wordreversal"
    cluster = aws_ecs_cluster.this.arn
    launch_type = "FARGATE"
    deployment_maximum_percent = 200
    deployment_minimum_healthy_percent = 0
    desired_count = 1
    task_definition = aws_ecs_task_definition.this.family
    network_configuration {
      assign_public_ip = true
      security_groups = [aws_security_group.wordreversal_ecs_sg.id]
      subnets = module.vpc.public_subnets
    }
    load_balancer {
        target_group_arn = aws_lb_target_group.this.arn
        container_name   = "frontend"
        container_port   = 80
        }
    }
module "wordreversal" {
    source = "cloudposse/ecs-container-definition/aws"
    container_name = "frontend"
    container_image = "awabamjad/wordreversalfrontend:latest"
  
}

resource "aws_ecs_task_definition" "this" {
  family                   = "wordreversal"
  requires_compatibilities = ["FARGATE"] # Use Fargate compatibility for running tasks
  network_mode             = "awsvpc"
  memory                   = "512" # Set the memory limit for the task
  cpu                      = "256" # Set the CPU units for the task

  # Define container definitions as a JSON-encoded array
  container_definitions = jsonencode([
    {
      name       = "frontend",
      image      = "awabamjad/wordreversalfrontend:latest",
      entryPoint = [],
      essential = true,
      portMappings = [
        {
          containerPort = 80,
          hostPort      = 80,
        }
      ],
      cpu         = 120,
      memory      = 250,
      networkMode = "awsvpc"

    }
  ])
}