resource "aws_launch_template" "ecs_lt" {
 name_prefix   = "ecs-template"
 image_id      = data.aws_ami.ubuntu.id
 instance_type = "t2.micro"

 key_name               = "awab-ec2-ecs"
 vpc_security_group_ids = [aws_security_group.ECS.id]
 iam_instance_profile {
   name = "ecsInstanceRole"
 }

 block_device_mappings {
   device_name = "/dev/xvda"
   ebs {
     volume_size = 30
     volume_type = "gp2"
   }
 }

 tag_specifications {
   resource_type = "instance"
   tags = {
     Name = "ecs-instance"
   }
 }

 user_data = filebase64("ecs.sh")
}
resource "aws_autoscaling_group" "ecs_asg" {
 vpc_zone_identifier = module.vpc.public_subnets
 desired_capacity    = 2
 max_size            = 3
 min_size            = 1

 launch_template {
   id      = aws_launch_template.ecs_lt.id
   version = "$Latest"
 }

 tag {
   key                 = "AmazonECSManaged"
   value               = true
   propagate_at_launch = true
 }
}