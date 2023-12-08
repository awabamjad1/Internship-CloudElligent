resource "aws_ecr_repository" "frontend" {
  name         = "frontend"
  force_delete = false

  tags = {
    Name        = "frontend"
    Owner       = "awab"
  }
}