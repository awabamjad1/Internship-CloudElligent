output "ec2_ip" {
    description = "EC2 IP address:"
    value = aws_instance.this.public_ip
}