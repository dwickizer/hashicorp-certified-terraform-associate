# Resource Block
# Resource-1: Create VPC
resource "aws_vpc" "terraform-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "terraform-vpc"
    "Owner" = "dwickizer"
  }
}
