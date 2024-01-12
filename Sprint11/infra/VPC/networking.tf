resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "Ig- Sprint 11 Project"
    Owner = "Awab"
    Environment = var.environment
    Project     = var.project_name
    Team        = var.team_name
  }
}
resource "aws_eip" "this" {
  vpc = true
  tags = {
    Name = "EIP- Sprint 11 Project"
    Owner = "Awab"
    Environment = var.environment
    Project     = var.project_name
    Team        = var.team_name
  }
}
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = aws_subnet.public.id
  tags = {
    Name = "Nat Gateway- Sprint 11 Project"
    Owner = "Awab"
    Environment = var.environment
    Project     = var.project_name
    Team        = var.team_name
  }
}