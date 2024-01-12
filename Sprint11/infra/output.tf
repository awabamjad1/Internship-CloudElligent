output "private_ec2_ip" {
  description = "IP address of private EC2"
  value       = aws_instance.private.private_ip
}
output "ssh_command_public" {
  value = "ssh -i \"ec2-awab.pem\" ubuntu@${aws_instance.public.public_ip}"
}
output "ssh_command_private" {
  value = "ssh -i \"ec2-awab.pem\" ubuntu@${aws_instance.private.private_ip}"
}