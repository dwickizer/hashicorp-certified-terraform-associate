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

# PLAY WITH /tmp folder in EC2 Instance with File Provisioner
  # Connection Block for Provisioners to connect to EC2 Instance
  connection {
    type = "ssh"
    host = self.public_ip # Understand what is "self"
    user = "ec2-user"
    password = ""
    private_key = file("~/mydev/creds/terraform-key.pem")
  }  

 # Copies the file-copy.html file to /tmp/file-copy.html
  provisioner "file" {
    source      = "apps/file-copy.html"
    destination = "/tmp/file-copy.html"
  }

# Copies the file to Apache Webserver /var/www/html directory
  provisioner "remote-exec" {
    inline = [
      "sleep 120",  # Will sleep for 120 seconds to ensure Apache webserver is provisioned using user_data
      "sudo cp /tmp/file-copy.html /var/www/html"
    ]
  }
}







