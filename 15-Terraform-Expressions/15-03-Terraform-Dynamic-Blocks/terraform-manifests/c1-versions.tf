# Terraform Block
terraform {
  required_version = "~> 1.0.3" # which means any version equal & above 1.0.3
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
      
  }
}

# Provider Block
provider "aws" {
  region  = var.aws_region
  profile = "default"
}
/*
Note-1:  AWS Credentials Profile (profile = "default") configured on your local desktop terminal  
$HOME/.aws/credentials
*/
