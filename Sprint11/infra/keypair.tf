resource "aws_key_pair" "ec2_private" {
key_name = "ec2-private"
public_key = tls_private_key.ec2_private.public_key_openssh
}
resource "tls_private_key" "ec2_private" {
algorithm = "RSA"
rsa_bits  = 4096
}
resource "local_file" "ec2_private" {
content  = tls_private_key.ec2_private.private_key_pem
filename = "ec2-private.pem"
}