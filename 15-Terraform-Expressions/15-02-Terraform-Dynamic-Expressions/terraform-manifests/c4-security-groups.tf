# Create Security Group for ELB (if it exists)

resource "aws_security_group" "vpc-tf-elb" {
  name        = "vpc-tf-elb-${terraform.workspace}"
  description = "ELB Security Group"
  vpc_id      = aws_vpc.vpc-tf.id
  count = (var.high_availability == true ? 1 : 0)
  tags = merge({"Name" = join("", ["vpc-tf-elb-", "${terraform.workspace}"])}, local.common_tags)

  ingress {
    description = "Allow Port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["192.80.55.64/27"]
  }

  ingress {
    description = "Allow Port 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["192.80.55.64/27"]
  }

  egress {
    description = "Allow all IP and Ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create Security Group - SSH Traffic
resource "aws_security_group" "vpc-tf-ssh" {
  name        = "vpc-tf-ssh-${terraform.workspace}"
  description = "Dev VPC SSH"
  vpc_id      = aws_vpc.vpc-tf.id
  tags = merge({"Name" = join("", ["vpc-tf-ssh-", "${terraform.workspace}"])}, local.common_tags)

  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.80.55.64/27"]
  }
  egress {
    description = "Allow all IP and Ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create Security Group - Web Traffic
resource "aws_security_group" "vpc-tf-web" {
  name        = "vpc-tf-web-${terraform.workspace}"
  description = "Web Traffic Security Group"
  vpc_id      = aws_vpc.vpc-tf.id
  tags = merge({"Name" = join("", ["vpc-tf-web-", "${terraform.workspace}"])}, local.common_tags)

  ingress {
    description = "Allow Port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["192.80.55.64/27"]
    security_groups = (var.high_availability == true ? 
      [aws_security_group.vpc-tf-elb[0].id] : [])
  }

  ingress {
    description = "Allow Port 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["192.80.55.64/27"]
  }


  egress {
    description = "Allow all IP and Ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
