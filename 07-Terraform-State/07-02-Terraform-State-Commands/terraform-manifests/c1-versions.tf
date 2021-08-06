# Terraform Block
terraform {
  required_version = "~> 1.0.3" # which means any version equal & above 1.0.3
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  # Adding Backend as S3 for Remote State Storage with State Locking
  backend "s3" {
    bucket = "terraform-backend-dw"
    key = "dev/terraform.tfstate"
    region = "us-gov-west-1"
    # For State Locking
    dynamodb_table = "terraform-dev-state-table"
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
