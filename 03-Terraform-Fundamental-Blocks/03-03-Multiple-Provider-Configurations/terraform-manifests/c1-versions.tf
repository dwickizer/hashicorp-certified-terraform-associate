# Terraform Block
terraform {
  required_version = "~> 1.0.3"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.51"
    }
  }
}

# Provider-1 for us-gov-east-1 (Default Provider)
provider "aws" {
  region = "us-gov-east-1"
  profile = "default"
}

# Provider-2 for us-gov-west-1
provider "aws" {
  region = "us-gov-west-1"
  profile = "default"
  alias = "aws-west-1"
}
