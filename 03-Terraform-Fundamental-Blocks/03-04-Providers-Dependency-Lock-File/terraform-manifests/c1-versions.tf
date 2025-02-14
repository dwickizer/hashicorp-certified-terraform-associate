# Terraform Settings Block
terraform {
  # Terraform Version
  required_version = "~> 1.0.3"
  required_providers {
    # AWS Provider 
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.0.0"
    }
    # Random Provider
    random = {
      source  = "hashicorp/random"
      version = "3.0.0"
    }
  }
}

# Provider Block
provider "aws" {
  region = "us-gov-west-1"
  profile = "default" # Defining it for default profile is Optional
}