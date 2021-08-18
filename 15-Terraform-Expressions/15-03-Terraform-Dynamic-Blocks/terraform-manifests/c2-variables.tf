# Input Variables
variable "aws_region" {
  description = "Region in which AWS resources to be created"
  type        = string
  default     = "us-gov-east-1"
}

variable "s3-name" {
  description = "The prefix for ec2 instances"
  type = string
  default = "c2dm-"
}

variable "team" {
  description = "The team responsible for the infrastructure"
  type = string
  default = "C2DM_DevOps"
}

variable "owner" {
  description = "The owner of the resource"
  type = string
  default = "dwickizer"
}

locals {
  common_tags = {
    Owner = var.owner
    Team = var.team
  }
}