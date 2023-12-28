resource "aws_security_group" "rds" {
  name_prefix = "rds_sg"
  vpc_id      = module.vpc.vpc_id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 0
    to_port     = 3306 //3306
  }
}
resource "aws_security_group" "ec2" {
  name_prefix = "ec2"
  vpc_id      = module.vpc.vpc_id
  #Ingress rule for allowing all connection on 22 port for ssh connection.
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
  }
  # For installing docker and aws cli, we are giving access to ec2 to talk freely on internet.
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 0
    to_port     = 65535
  }
}