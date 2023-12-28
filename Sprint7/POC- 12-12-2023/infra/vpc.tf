module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "wordreversal"
  cidr = "10.2.0.0/16"

  azs = ["us-east-1a", "us-east-1b"]

  public_subnets =["10.2.1.0/24", "10.2.2.0/24"]
  enable_nat_gateway =false
  enable_vpn_gateway = false
  
  tags = {
    Name = "wordreversal-awab"
    Owner = "awab"
  }
}
resource "aws_db_subnet_group" "db_subnet_group" {
  description = "Subnet group for RDS"
  subnet_ids  = module.vpc.public_subnets
}