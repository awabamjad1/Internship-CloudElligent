resource "aws_security_group" "ec2_public" {
  name_prefix = "ec2"
  vpc_id      = module.vpc.vpc_id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = -1
    from_port   = 0
    to_port     = 0
  }
  tags = {
    Name = "sg-ec2-public-awab"
    Owner = "awab"
  }
}
resource "aws_security_group" "ec2_private" {
  name_prefix = "ec2"
  vpc_id      = module.vpc.vpc_id
  ingress {
    security_groups  = [aws_security_group.ec2_public.id]
    protocol    = "tcp"
    from_port   = 0
    to_port     = 65535
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = -1
    from_port   = 0
    to_port     = 0
  }
  tags = {
    Name = "sg-ec2-private-awab"
    Owner = "awab"
  }
}