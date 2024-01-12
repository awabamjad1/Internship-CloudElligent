resource "aws_security_group" "ec2" {
  name_prefix = "ec2"
  vpc_id = aws_vpc.default.id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 5000
    to_port     = 5000
  }
  # For installing docker and aws cli, we are giving access to ec2 to talk freely on internet.
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 0
    to_port     = 65535
  }
}