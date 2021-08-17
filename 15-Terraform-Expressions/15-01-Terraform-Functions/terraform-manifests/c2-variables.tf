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