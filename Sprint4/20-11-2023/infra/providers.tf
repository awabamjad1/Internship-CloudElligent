terraform {
  required_version = ">= 1.5"
  cloud {
    organization = "Demo-org-cloudorg"

    workspaces {
      name = "demo"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.9"
    }
  }
}