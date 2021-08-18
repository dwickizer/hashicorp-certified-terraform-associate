# Input Variables
variable "aws_region" {
  description = "Region in which AWS resources to be created"
  type        = string
  default     = "us-gov-east-1"
}

variable "ec2_instance_type" {
  description = "EC2 Instance Type"
  type = string
  default = "t3.micro"
}

variable "package_name" {
  description = "Provide Package that need to be installed with user_data"
  type = string
  default = "httpd"
}

variable "vpc_cidr" {
  description = "IPv4 CIDR for VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "subnet_cidrs" {
  description = "List of IPv4 CIDRs for VPC subnets"
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "availability_zones" {
  description = "List of Availability Zones resources will be created"
  type = list(string)
  default = ["us-gov-east-1a", "us-gov-east-1b"]
}


variable "high_availability" {
  type        = bool
  description = "If this is a multiple instance deployment, choose `true` to deploy 2 instances"
  default     = false
  #default     = true
}

variable "ec2-name" {
  description = "The prefix for ec2 instances"
  type = string
  default = "c2dm-"
}

variable "team" {
  description = "The team responsible for the infrastructure"
  type = string
  default     = "C2DM_DevOps"
}

variable "owner" {
  description = "The owner of the resource"
  type = string
  default     = "dwickizer"
}