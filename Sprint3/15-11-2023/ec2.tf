module "ec2_instance" {
  depends_on = [ null_resource.this ]
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"
  ami = data.aws_ami.ubuntu.id

  instance_type          = "t2.micro"
  key_name               = "awabamjadkey"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.ec2.id]
  associate_public_ip_address = true
  user_data = "${file("userdata.sh")}"
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}