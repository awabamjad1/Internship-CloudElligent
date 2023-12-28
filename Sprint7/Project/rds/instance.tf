resource "aws_instance" "this" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  associate_public_ip_address = true
  //key_name                    = "awabamjadkey"
  iam_instance_profile        = aws_iam_instance_profile.ec2.name
  user_data = "${file("userdata.sh")}"
  tags = {
    Name = "ec2-awab"
    Owner = "awab"
  }
}