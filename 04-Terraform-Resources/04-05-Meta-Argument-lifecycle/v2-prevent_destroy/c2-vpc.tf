# Resources Block
# Resource-1: Create VPC
resource "aws_vpc" "vpc-dev" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "vpc-dev"
    "Owner" = "dwickizer"
  }
}

# Resource-2: Create Subnets
resource "aws_subnet" "vpc-dev-public-subnet-1" {
  vpc_id                  = aws_vpc.vpc-dev.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-gov-west-1a"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "vpc-dev-public-subnet-1"
    "Owner" = "dwickizer"
  }
}

resource "aws_subnet" "vpc-dev-public-subnet-2" {
  vpc_id                  = aws_vpc.vpc-dev.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-gov-west-1b"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "vpc-dev-public-subnet-2"
    "Owner" = "dwickizer"
  }
}

# Resource-3: Internet Gateway
resource "aws_internet_gateway" "vpc-dev-igw" {
  vpc_id = aws_vpc.vpc-dev.id
  tags = {
    "Name" = "vpc-dev-igw"
    "Owner" = "dwickizer"
  } 
}

# Resource-4: Create Route Table
resource "aws_route_table" "vpc-dev-public-route-table" {
  vpc_id = aws_vpc.vpc-dev.id
  tags = {
    "Name" = "vpc-dev-public-route-table"
    "Owner" = "dwickizer"
  } 

}

# Resource-5: Create Route in Route Table for Internet Access
resource "aws_route" "vpc-dev-public-route" {
  route_table_id         = aws_route_table.vpc-dev-public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc-dev-igw.id
}

# Resource-6: Associate the Route Table with the Subnet
resource "aws_route_table_association" "vpc-dev-public-route-table-association-1" {
  route_table_id = aws_route_table.vpc-dev-public-route-table.id
  subnet_id =  aws_subnet.vpc-dev-public-subnet-1.id
}

resource "aws_route_table_association" "vpc-dev-public-route-table-association-2" {
  route_table_id = aws_route_table.vpc-dev-public-route-table.id
  subnet_id =  aws_subnet.vpc-dev-public-subnet-2.id
}

# Resource-7: Create Security Group
resource "aws_security_group" "dev-vpc-sg" {
  name        = "dev-vpc-default-sg"
  description = "Dev VPC Default Security Group"
  vpc_id      = aws_vpc.vpc-dev.id
  tags = {
    "Name" = "dev-vpc-sg"
    "Owner" = "dwickizer"
  }

  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.80.55.64/27"]
  }

  ingress {
    description = "Allow Port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["192.80.55.64/27"]
  }

  ingress {
    description = "Allow ping"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["192.80.55.64/27"]
  }

  egress {
    description = "Allow all IP and Ports Outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

