# Resources Block
# Resource-1: Create VPC
resource "aws_vpc" "vpc-tf" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "vpc-tf"
    "Owner" = "dwickizer"
  }
}

# Resource-2: Create Subnets
resource "aws_subnet" "vpc-tf-public-subnet-1" {
  vpc_id                  = aws_vpc.vpc-tf.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-gov-west-1a"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "vpc-tf-public-subnet-1"
    "Owner" = "dwickizer"
  }
}

resource "aws_subnet" "vpc-tf-public-subnet-2" {
  vpc_id                  = aws_vpc.vpc-tf.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-gov-west-1b"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "vpc-tf-public-subnet-2"
    "Owner" = "dwickizer"
  }
}

# Resource-3: Internet Gateway
resource "aws_internet_gateway" "vpc-tf-igw" {
  vpc_id = aws_vpc.vpc-tf.id
  tags = {
    "Name" = "vpc-tf-igw"
    "Owner" = "dwickizer"
  } 
}

# Resource-4: Create Route Table
resource "aws_route_table" "vpc-tf-public-route-table" {
  vpc_id = aws_vpc.vpc-tf.id
  tags = {
    "Name" = "vpc-tf-public-route-table"
    "Owner" = "dwickizer"
  } 

}

# Resource-5: Create Route in Route Table for Internet Access
resource "aws_route" "vpc-tf-public-route" {
  route_table_id         = aws_route_table.vpc-tf-public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc-tf-igw.id
}

# Resource-6: Associate the Route Table with the Subnet
resource "aws_route_table_association" "vpc-tf-public-route-table-association-1" {
  route_table_id = aws_route_table.vpc-tf-public-route-table.id
  subnet_id =  aws_subnet.vpc-tf-public-subnet-1.id
}

resource "aws_route_table_association" "vpc-tf-public-route-table-association-2" {
  route_table_id = aws_route_table.vpc-tf-public-route-table.id
  subnet_id =  aws_subnet.vpc-tf-public-subnet-2.id
}

# Resource-7: Create Security Group
# See c4-security-groups.tf

