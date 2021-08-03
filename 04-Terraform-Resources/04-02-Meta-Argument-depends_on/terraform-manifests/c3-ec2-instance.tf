# Resource-8: Create EC2 Instance
resource "aws_instance" "my-ec2-vm" {
  ami                    = "ami-0645cf757ebd107e5" # Amazon Linux
  instance_type          = "t2.micro"
  key_name               = "terraform-key"
  subnet_id              = aws_subnet.vpc-dev-public-subnet-1.id
  vpc_security_group_ids = [aws_security_group.dev-vpc-sg.id]
  user_data = file("apache-install.sh")
  
  # Alternative approach
  # user_data = <<-EOF
    #!/bin/bash
    # sudo yum update -y
    # sudo yum install httpd -y
    # sudo systemctl enable httpd
    # sudo systemctl start httpd
    # sudo echo "<h1>Welcome to C2DM created using Terraform in us-gov-west-1 Region</h1>" > /var/www/html/index.html
    # EOF
  tags = {
    "Name" = "my-ec2-vm"
    "Owner" = "dwickizer"
  }    
}
