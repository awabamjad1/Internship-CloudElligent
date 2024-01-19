resource "aws_launch_configuration" "sample" {
  name = "sample"
  
  image_id        = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"     
  associate_public_ip_address = true
  user_data = templatefile("${path.module}/userdata.sh", {
    aws_rds_cluster_endpoint               = aws_rds_cluster.aurora_cluster.endpoint
    database_username                      = var.database_username
    database_user_password                 = var.database_user_password
    database_name                          = "sampledbawab"
  })
  security_groups = [aws_security_group.ec2.id]
  key_name = "ec2-awab"

  lifecycle {
    create_before_destroy = true
  }
  
}

resource "aws_autoscaling_group" "sample" {
  desired_capacity     = 2
  max_size             = 5
  min_size             = 1

  launch_configuration = aws_launch_configuration.sample.id
  vpc_zone_identifier  = module.vpc.public_subnets

  tag {
    key                 = "asg-awab"
    value               = "asg-awab"
    propagate_at_launch = true
  }

  health_check_type          = "EC2"
  health_check_grace_period  = 300

  
}
