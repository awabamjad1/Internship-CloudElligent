output "ec2_1_ip" {
    description = "1st EC2 IP address:"
    value = module.ec2_instance[0].public_ip
}
output "ec2_2_ip" {
    description = "2nd EC2 IP address:"
    value = module.ec2_instance[1].public_ip
}
output "alb_dns" {
  description = "alb_dns"
  value = aws_lb.this.dns_name
}