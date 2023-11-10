resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = {
    createdby = "Awab Amjad"
    Environment = "Development"
    Project     = "Sprint2"
  }
}
# Route table association resource definition for the public subnet
resource "aws_route_table_association" "flaskify-public_subnet_association" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}