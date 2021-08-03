# Create EC2 Instance
resource "aws_instance" "web" {
  ami           = "ami-0645cf757ebd107e5" # Amazon Linux
  instance_type = "t2.micro"
  key_name               = "terraform-key"
  subnet_id              = aws_subnet.vpc-dev-public-subnet-1.id
  vpc_security_group_ids = [aws_security_group.dev-vpc-sg.id]
  user_data = file("apache-install.sh")
  count = 5
  tags = {
    "Name" = "web-${count.index}"
    "Owner" = "dwickizer"
  }
}
