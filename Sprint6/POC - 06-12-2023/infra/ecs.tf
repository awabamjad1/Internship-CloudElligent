resource "aws_ecs_cluster" "this" {
  name = "this"
}

resource "aws_ecs_service" "this" {
  name            = "this"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  launch_type     = "FARGATE"

  deployment_controller {
    type = "CODE_DEPLOY"
  } 

  network_configuration {
    subnets         = module.vpc.public_subnets
    security_groups = [aws_security_group.ECS.id]    
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.blue.arn
    container_name   = "frontend"
    container_port   = 80
  }
  desired_count = 2

}

# Define an AWS ECS task definition for the Flaskify application
resource "aws_ecs_task_definition" "this" {
  family                   = "this"
  requires_compatibilities = ["FARGATE"] # Use Fargate compatibility for running tasks
  network_mode             = "awsvpc"
  memory                   = "512"
  cpu                      = "256"
  execution_role_arn       = aws_iam_role.ecr.arn
  task_role_arn            = aws_iam_role.ecr.arn

  # Define container definitions as a JSON-encoded array
  container_definitions = jsonencode([
    {
      name       = "frontend",
      image      = "awabamjad/wordreversalbackend:latest",
      entryPoint = [],
      environment = [
        {
          name  = "MYSQL_USER",
          value = "123"
        }
      ],
      essential = true,
      portMappings = [
        {
          containerPort = 80,
          hostPort      = 80
        }
      ],
      cpu    = 250,
      memory = 510,
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-group"         = "log-awab",
          "awslogs-region"        = "us-east-1",
          "awslogs-stream-prefix" = "log"
        }
      }
    }
  ])
  
}