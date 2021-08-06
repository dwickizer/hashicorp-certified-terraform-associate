# Create EC2 Instance
resource "aws_instance" "my-ec2-vm" {
  ami = data.aws_ami.amzlinux.id
  instance_type = var.ec2_instance_type
  key_name = "terraform-key"
  subnet_id = aws_subnet.vpc-tf-public-subnet-1.id
  user_data = file("apache-install.sh")
  vpc_security_group_ids = [aws_security_group.vpc-tf-ssh.id, aws_security_group.vpc-tf-web.id]
  tags = {
    "Name" = "webvars0701"
    "Owner" = "dwickizer"
  }
}
