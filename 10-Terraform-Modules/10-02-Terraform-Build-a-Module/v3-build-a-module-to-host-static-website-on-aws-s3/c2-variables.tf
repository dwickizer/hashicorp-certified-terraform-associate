# Input Variables
variable "aws_region" {
  description = "Region in which AWS resources to be created"
  type        = string
  default     = "us-gov-east-1"
}

## Create Variable for S3 Bucket Name
variable "my_s3_bucket" {
  description = "S3 Bucket name that we pass to S3 Custom Module"
  type = string
  default = "c2dm-test"
}

## Create Variable for S3 Bucket Tags
variable "my_s3_tags" {
  description = "Tags to set on the bucket"
  type = map(string)
  default = {
    Terraform = "true"
    Environment = "dev"
    Owner = "dwickizer"
  }
}
