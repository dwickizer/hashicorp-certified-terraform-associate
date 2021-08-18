# Define Random ID Resource
resource "random_id" "id" {
  byte_length = 8
}

# Create Locals
locals {
  count = (var.high_availability == true ? 2 : 1)
  owner = var.owner
  team = var.team

  subnet1_id = aws_subnet.vpc-tf-public-subnet-1.id
  subnet2_id = aws_subnet.vpc-tf-public-subnet-2.id

  subnet_ids = [local.subnet1_id, local.subnet2_id]

  common_tags = {
    Owner = local.owner
    Team = local.team
  }
}

# Create EC2 Instance
resource "aws_instance" "my-ec2-vm" {
  ami = data.aws_ami.amzlinux.id
  instance_type = var.ec2_instance_type
  key_name = "terraform-key"
  user_data = templatefile("user_data.tmpl", {package_name = var.package_name})
  vpc_security_group_ids = [aws_security_group.vpc-tf-ssh.id, aws_security_group.vpc-tf-web.id]
  # Dynamic expressions
  count = local.count
  tags = merge({"Name" = join("", [var.ec2-name, "${terraform.workspace}", "-", "${count.index}"])}, local.common_tags )
  availability_zone = var.availability_zones[count.index]
  subnet_id = local.subnet_ids[count.index]
}
