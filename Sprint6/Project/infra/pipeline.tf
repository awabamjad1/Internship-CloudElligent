resource "aws_s3_bucket" "cicd-bucket" {
  bucket        = "cicdbucketawab"
  force_destroy = true
}

resource "aws_codebuild_project" "this" {
  badge_enabled = false 
  build_timeout = 60    #(in minutes)
  name          = "wordreversal"
  service_role  = aws_iam_role.containerAppBuildProjectRole.arn
  tags = {
    Name = "wordreversal"
    Owner = "Awab"
    Environment = "Build"
  }
  artifacts {
    encryption_disabled = true
    packaging           = "NONE"
    type                = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
    type                        = "LINUX_CONTAINER"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "buildlogs"
      stream_name = "buildstream"
    }

    s3_logs {
      encryption_disabled = false
      status              = "DISABLED"
    }
  }
  source {
    buildspec = file("buildspec.yml")

    git_clone_depth     = 0
    insecure_ssl        = false
    report_build_status = false
    type                = "CODEPIPELINE" 
  }
}
resource "aws_codepipeline" "this" {
  depends_on = [ aws_ecs_cluster.this, aws_ecs_service.this ]
  name     = "wordreversal"
  role_arn = aws_iam_role.codepipeline.arn
  tags = {
    Environment = "dev"
  }
  artifact_store {
    location = aws_s3_bucket.cicd-bucket.id
    type     = "S3"
  }
  stage {
    name = "Source"
    action {
      name             = "SourceAction"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["Source"]

      configuration = {
        OAuthToken    = var.github_token
        Owner         = "awabamjad1"
        Repo          = "pipeline"
        Branch        = "main"
        PollForSourceChanges = "true" # Optional: Set to "true" for periodic checks
      }
    }
  }
  stage {
    name = "Build"
    action {
      name             = "Build"
      category         = "Build"
      input_artifacts  = ["Source"]
      output_artifacts = ["Build"]
      owner            = "AWS"
      provider         = "CodeBuild"
      run_order        = 1
      version          = "1"
      configuration = {
        "EnvironmentVariables" = jsonencode(
          [
            {
              name  = "frontendimageuri"
              type  = "PLAINTEXT"
              value = "${aws_ecr_repository.frontend.repository_url}:latest"
            },
            {
              name  = "executionrole"
              type  = "PLAINTEXT"
              value = aws_iam_role.ecr.arn
            }
          ]
        )
        "ProjectName" = aws_codebuild_project.this.name
      }
    }
  }
  stage {
    name = "Deploy"
    action {
      category        = "Deploy"
      name            = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeployToECS"
      version         = "1"
      input_artifacts = ["Build"]

      configuration = {
        ApplicationName                = aws_codedeploy_app.this.name
        DeploymentGroupName            = aws_codedeploy_deployment_group.this.deployment_group_name
        AppSpecTemplateArtifact        = "Build"
        AppSpecTemplatePath            = "appspec.yaml"
        TaskDefinitionTemplateArtifact = "Build"       
        TaskDefinitionTemplatePath     = "taskdef.json" 
      }
    }
  }
}