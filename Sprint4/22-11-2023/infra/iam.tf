# Define an IAM policy document for ECR and ECS permissions
data "aws_iam_policy_document" "ecr_iam_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken", # line to allow GetAuthorizationToken
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
    ]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "ecs:DescribeServices", # Add ECS permission
    ]
  }
}
# Define an IAM role for ECR and ECS access
resource "aws_iam_role" "ecr_role" {
  name = "ECR-Access-Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
  tags = {
    Name = "ecr-awab"
    Owner = "Awab"
  }
}
# Create the IAM Instance Profile
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "Flaskify_EC2InstanceProfile"
  role = aws_iam_role.ecr_role.name
}
# Define an IAM policy document for assuming a role
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codedeploy.amazonaws.com"]
    }
    
    actions = ["sts:AssumeRole"]
  }
}
# Define an IAM policy document for assuming a role
data "aws_iam_policy_document" "ecs_iam_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "ecs:DescribeServices",
    ]
    resources = ["*"]
  }
}
# Define an IAM role for ECS and attach the assume role policy
resource "aws_iam_role" "ecs_role" {
  name               = "ecs_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}
# Define an IAM policy for ECS
resource "aws_iam_policy" "ecs_policy" {
  name        = "ECS_DescribeServices_Policy"
  description = "Policy to allow describing ECS services"
  policy      = data.aws_iam_policy_document.ecs_iam_policy_document.json
}
# Attach the ECS policy to the ECS role
resource "aws_iam_role_policy_attachment" "ecs_attachment" {
  policy_arn = aws_iam_policy.ecs_policy.arn
  role       = aws_iam_role.ecr_role.name
}