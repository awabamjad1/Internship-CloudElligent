module "vpc" {
  source = "./VPC"
  region = "us-east-1"
  CIDR = "10.0.0.0/16"
  Name = "Capstone Project I- Awab"
}