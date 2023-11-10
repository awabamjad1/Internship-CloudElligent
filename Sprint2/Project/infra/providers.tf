terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.9"
    }

    # Add a version constraint for the null provider
    null = {
      source  = "hashicorp/null"
      version = ">= 3.0"
    }
  }
}