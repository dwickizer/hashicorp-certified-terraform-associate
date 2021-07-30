terraform {
  # Required Terraform Version
  required_version = "~> 1.0.3"
  # Required Providers and their Versions
  required_providers {
     aws = {
      source = "hashicorp/aws"
      version = "3.51.0"
    }
   random = {
      source = "hashicorp/random"
      version = "3.1.0"
    }
  }

  # Remote Backend for storing Terraform State in S3 bucket 
  backend "s3" {
    bucket = "terraform-dw"
    key    = "key/terraform.tfstate"
    region = "us-gov-west-1"
  }
  # Experimental Features (Not required)
  # experiments = [ example ]
  # Passing Metadata to Providers (Super Advanced - Terraform documentation says not needed in many cases)
  provider_meta "my-provider" {
    hello = "world"
  }
}