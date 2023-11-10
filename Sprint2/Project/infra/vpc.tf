resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
  tags = {
    name = "vpc-awab"
    createdby = "Awab Amjad"
    Environment = "Development"
    Project     = "Sprint2"
  }
}
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    createdby = "Awab Amjad"
    Environment = "Development"
    Project     = "Sprint2"
  }
}
resource "aws_subnet" "public" {
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  vpc_id = aws_vpc.this.id
}