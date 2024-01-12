module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "wordreversal"
  cidr = "10.2.0.0/16"

  azs = ["us-east-1a", "us-east-1b"]

  public_subnets =["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24", "10.2.4.0/24"]
  enable_nat_gateway =false
  enable_vpn_gateway = false
  map_public_ip_on_launch = true
  tags = {
    Name = "k8-awab"
    Owner = "awab"
  }
}