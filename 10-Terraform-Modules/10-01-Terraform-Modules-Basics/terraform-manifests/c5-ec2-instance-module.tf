# AWS EC2 Instance Module
module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  instance_count         = terraform.workspace == "default" ? 2 : 1
  name                   = "mod-vm"

  ami                    = data.aws_ami.amzlinux.id 
  instance_type          = var.ec2_instance_type
  key_name               = "terraform-key"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.vpc-tf-ssh.id, aws_security_group.vpc-tf-web.id] # Get Default VPC Security Group ID and replace
  subnet_id              = aws_subnet.vpc-tf-public-subnet-1.id # Get one public subnet id from default vpc and replace
  user_data              = file("apache-install.sh") 
  
  tags = {
    Name        = "mod-vm"
    Terraform   = "true"
    Environment = "${terraform.workspace}"
    Owner       = "dwickizer"
  }
}

