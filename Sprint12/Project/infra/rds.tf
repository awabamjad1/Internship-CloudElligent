resource "aws_rds_cluster" "aurora_cluster" {
  engine                 = "aurora-mysql"
  engine_version         = "5.7.mysql_aurora.2.12.0"
  vpc_security_group_ids = [aws_security_group.rds.id]
  database_name          = "sampledbawab"
  master_username        = var.database_username
  master_password        = var.database_user_password
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.id
}
resource "aws_rds_cluster_instance" "aurora_cluster_i1" {
  identifier         = "cluster-instance"
  engine             = aws_rds_cluster.aurora_cluster.engine
  engine_version     = aws_rds_cluster.aurora_cluster.engine_version
  cluster_identifier = aws_rds_cluster.aurora_cluster.id
  instance_class     = "db.t3.small"
}