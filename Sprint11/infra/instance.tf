resource "aws_instance" "public" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = module.vpc.public_subnet_id
  vpc_security_group_ids      = [aws_security_group.ec2_public.id]
  associate_public_ip_address = true
  key_name                    = "ec2-awab"
  iam_instance_profile        = aws_iam_instance_profile.ec2_public.name

  tags = {
    Name = "ec2-awab-public"
    Owner = "Awab"
  }
}
resource "aws_instance" "private" {
  depends_on = [ null_resource.file_upload_public_s3, aws_key_pair.ec2_private ]
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = module.vpc.private_subnet_id
  vpc_security_group_ids      = [aws_security_group.ec2_private.id]
  associate_public_ip_address = false
  key_name                    = "ec2-private"
  iam_instance_profile        = aws_iam_instance_profile.Ec2_Private.name
  user_data = "${file("userdata.sh")}"
  tags = {
    Name = "ec2-awab-private"
    Owner = "Awab"
  }
}
