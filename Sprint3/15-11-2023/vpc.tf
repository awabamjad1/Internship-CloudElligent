module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "test"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a"]
  private_subnets = ["10.0.1.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false
  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
