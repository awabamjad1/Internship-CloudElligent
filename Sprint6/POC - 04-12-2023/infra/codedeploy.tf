resource "aws_codedeploy_app" "this" {
  name             = "wordreversal"
  compute_platform = "ECS"
}
resource "aws_codedeploy_deployment_config" "this" {
  deployment_config_name = "wordreversal"
  compute_platform       = "ECS"

  traffic_routing_config {
    type = "TimeBasedLinear" 
    time_based_linear {
      interval   = 120
      percentage = 30 
    }
  } 
}

resource "aws_codedeploy_deployment_group" "this" {
  app_name              = aws_codedeploy_app.this.name
  deployment_group_name = "codedeploy_deployment"
  service_role_arn      = aws_iam_role.codepipeline.arn

  deployment_config_name = aws_codedeploy_deployment_config.this.deployment_config_name

  ecs_service {
    cluster_name = aws_ecs_cluster.this.name
    service_name = aws_ecs_service.this.name
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"   
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout    = "CONTINUE_DEPLOYMENT"
      wait_time_in_minutes = 0                   
    }

    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 10        
    }
  }

  # Configure load balancer information for traffic routing.
  load_balancer_info {
    target_group_pair_info {
      target_group {
        name = aws_lb_target_group.blue.name 
      }

      target_group {
        name = aws_lb_target_group.green.name 
      }

      prod_traffic_route {
        listener_arns = [aws_lb_listener.http.arn]
      }
    }
  }
}
