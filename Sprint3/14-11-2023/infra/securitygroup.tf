resource "aws_security_group" "ec2" {
  name_prefix = "ec2"
  #Ingress rule for allowing all connection on 22 port for ssh connection.
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
  }
  # Ingress rule for allowing connection to backend application running on ec2 instance.
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 5000
    to_port     = 5000
  }
  # Ingress rule for allowing connection to frontend application on port 80.
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
  }
  # For installing docker and aws cli, we are giving access to ec2 to talk freely on internet.
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 0
    to_port     = 65535
  }
}