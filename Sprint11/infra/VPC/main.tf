resource "aws_vpc" "this" {
  cidr_block = var.CIDR
  tags = {
    Name        = var.Name
    Environment = var.environment
    Project     = var.project_name
    Team        = var.team_name
  }
}