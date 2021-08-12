# Create EC2 Instance - Amazon2 Linux
resource "aws_instance" "my-ec2-vm" {
  ami = data.aws_ami.amzlinux.id
  instance_type = var.ec2_instance_type
  key_name = "terraform-key"
  count = terraform.workspace == "default" ? 2 : 1
  subnet_id = aws_subnet.vpc-tf-public-subnet-1.id
  user_data = file("apache-install.sh")
  vpc_security_group_ids = [aws_security_group.vpc-tf-ssh.id, aws_security_group.vpc-tf-web.id]
  tags = {
    "Name" = "vm-${terraform.workspace}-${count.index}"
    "Owner" = "dwickizer"
  }

 # local-exec provisioner (Creation-Time Provisioner - Triggered during Create Resource)
  provisioner "local-exec" {
    command = "echo ${aws_instance.my-ec2-vm[count.index].private_ip} >> creation-time-private-ip.txt"
    working_dir = "local-exec-output-files/"
    #on_failure = continue
  }

  # local-exec provisioner - (Destroy-Time Provisioner - Triggered during Destroy Resource)
  provisioner "local-exec" {
    when    = destroy
    command = "echo Destroy-time provisioner: Instance Destroyed at `date` >> destroy-time.txt"
    working_dir = "local-exec-output-files/"
  }  

}







