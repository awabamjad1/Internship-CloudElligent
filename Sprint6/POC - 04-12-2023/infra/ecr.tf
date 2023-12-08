resource "aws_ecr_repository" "frontend" {
  name         = "frontend"
  force_delete = true

  tags = {
    Name        = "frontend"
    Owner       = "awab"
  }
}