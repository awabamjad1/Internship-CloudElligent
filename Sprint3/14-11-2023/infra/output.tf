output "ec2_ip" {
    description = "EC2 IP address:"
    value = module.ec2_instance.public_ip
}