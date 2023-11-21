resource "aws_efs_file_system" "file_system" {
  creation_token   = "efs-test"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
  tags = {
    Name = "efs-test"
  }
}
resource "aws_efs_mount_target" "mount_targets" {
  count           = 1
  file_system_id  = aws_efs_file_system.file_system.id
  subnet_id       = module.vpc.public_subnets[count.index]
  security_groups = [aws_security_group.ec2.id]
}