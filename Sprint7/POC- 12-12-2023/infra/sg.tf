resource "aws_security_group" "rds" {
  name_prefix = "rds_sg"
  vpc_id      = module.vpc.vpc_id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 3306
    to_port     = 3306
  }
}