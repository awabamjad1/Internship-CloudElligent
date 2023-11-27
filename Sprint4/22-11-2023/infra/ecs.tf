resource "aws_ecs_cluster" "this" {
  name = "wordreversal-cluster"

  tags = {
    Name = "word-reversal-awab"
    Owner = "Awab"
  }
}
# Define an AWS ECS service for the Flaskify application
resource "aws_ecs_service" "this" {
  name            = "wordreversal-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  launch_type     = "FARGATE"

  # Configure network settings for the ECS service
  network_configuration {
    subnets         = module.vpc.public_subnets # Use the private subnets for the ECS service
    security_groups = [aws_security_group.wordreversal_ecs_sg.id]     # Use the ECS security group
    assign_public_ip = true
  }

  desired_count = 1 # Set the desired number of tasks/containers

  tags = {
    Name  = "wordreversal-awab"
    Owner = "Awab "
  }
}
# Define an AWS ECS task definition for the Flaskify application
resource "aws_ecs_task_definition" "this" {
  family                   = "wordreversal"
  requires_compatibilities = ["FARGATE"] # Use Fargate compatibility for running tasks
  network_mode             = "awsvpc"
  memory                   = "512" # Set the memory limit for the task
  cpu                      = "256" # Set the CPU units for the task
  execution_role_arn       = aws_iam_role.ecr_role.arn
  task_role_arn            = aws_iam_role.ecr_role.arn

  # Define container definitions as a JSON-encoded array
  container_definitions = jsonencode([
    {
      name       = "backend",
      image      = "awabamjad/wordreversalbackend:latest",
      entryPoint = [],
      essential = true,
      portMappings = [
        {
          containerPort = 5000,
          hostPort      = 5000
        }
      ],
      cpu         = 120,
      memory      = 250,
      networkMode = "awsvpc"
    },
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