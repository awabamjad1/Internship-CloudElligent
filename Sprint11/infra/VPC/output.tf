output "vpc_id" {
  description = "Output for the VPC ID"
  value       = aws_vpc.this.id
}
output "public_subnet_id" {
  description = "Id of Public Subnet"
  value       = aws_subnet.public.id
}
output "private_subnet_id" {
  description = "Id of Private Subnet"
  value       = aws_subnet.private.id
}