resource "aws_subnet" "private" {
  cidr_block        = "10.0.2.0/24"
  vpc_id            = aws_vpc.this.id
  availability_zone = "us-east-1a"
  tags = {
    Name        = "Private"
    Environment = var.environment
    Project     = var.project_name
    Team        = var.team_name
  }
}
resource "aws_subnet" "public" {
  cidr_block        = "10.0.3.0/24"
  vpc_id            = aws_vpc.this.id
  availability_zone = "us-east-1b"
  tags = {
    Name        = "Public"
    Environment = var.environment
    Project     = var.project_name
    Team        = var.team_name
  }
}

