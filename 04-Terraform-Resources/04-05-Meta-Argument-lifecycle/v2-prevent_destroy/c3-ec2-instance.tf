# Create EC2 Instance
resource "aws_instance" "web" {
  ami = "ami-0645cf757ebd107e5" # Amazon Linux
  instance_type = "t2.micro"
  key_name = "terraform-key"
  subnet_id = aws_subnet.vpc-dev-public-subnet-1.id
  # subnet_id = aws_subnet.vpc-dev-public-subnet-2.id
  vpc_security_group_ids = [aws_security_group.dev-vpc-sg.id]
  user_data = file("apache-install.sh")
  tags = {
    "Name" = "web-2"
    "Owner" = "dwickizer"
  }
  lifecycle {
    prevent_destroy = true # Default is false
  }
}

