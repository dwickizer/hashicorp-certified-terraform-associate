# Create EC2 Instance
resource "aws_instance" "my-ec2-vm" {
  ami = var.ec2_ami_id
  instance_type = var.ec2_instance_type[1]
  key_name = "terraform-key"
  subnet_id = aws_subnet.vpc-tf-public-subnet-1.id
  # subnet_id = aws_subnet.vpc-tf-public-subnet-2.id
  count = var.ec2_instance_count
  user_data = file("apache-install.sh")
  vpc_security_group_ids = [aws_security_group.vpc-tf-ssh.id, aws_security_group.vpc-tf-web.id]
  tags = {
    "Name" = "webvars4-${count.index}"
    "Owner" = "dwickizer"
  }
}
