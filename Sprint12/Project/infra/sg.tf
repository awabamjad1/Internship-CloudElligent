resource "aws_security_group" "ec2" {
  name_prefix = "ec2"
  vpc_id      = module.vpc.vpc_id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
  }
  ingress {
    security_groups = [aws_security_group.lb.id]
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 0
    to_port     = 65535
  }
  tags = {
    Name = "sg-ec2-awab"
    Owner = "awab"
  }
}

resource "aws_security_group" "rds" {
  name_prefix = "ec2"
  vpc_id      = module.vpc.vpc_id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 3306
    to_port     = 3306
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 0
    to_port     = 65535
  }
  tags = {
    Name = "sg-ec2-awab"
    Owner = "awab"
  }
}

resource "aws_security_group" "lb" {
  name_prefix = "ec2"
  vpc_id      = module.vpc.vpc_id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 0
    to_port     = 65535
  }
  tags = {
    Name = "sg-ec2-awab"
    Owner = "awab"
  }
}