module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"
  ami = data.aws_ami.ubuntu.id
  count = 2

  subnet_id = module.vpc.public_subnets[0]

  instance_type          = "t2.micro"
  key_name               = "awabamjadkey"
  monitoring             = true

  vpc_security_group_ids = [aws_security_group.ec2.id]
  associate_public_ip_address = true
  user_data = file("userdata.sh")

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}