# Create EC2 Instance - Amazon2 Linux
resource "aws_instance" "my-ec2-vm" {
  ami = data.aws_ami.amzlinux.id
  instance_type = var.ec2_instance_type
  key_name = "terraform-key"
  # count = terraform.workspace == "default" ? 2 : 1
  subnet_id = aws_subnet.vpc-tf-public-subnet-1.id
  user_data = file("apache-install.sh")
  vpc_security_group_ids = [aws_security_group.vpc-tf-ssh.id, aws_security_group.vpc-tf-web.id]
  tags = {
    "Name" = "vm-${terraform.workspace}-0"
    "Owner" = "dwickizer"
  }
}

  # Wait for 90 seconds after creating the above EC2 Instance 
  # for Apache to load
resource "time_sleep" "wait_90_seconds" {
  depends_on = [aws_instance.my-ec2-vm]
  create_duration = "90s"
}

# Sync App1 Static Content to Webserver using Provisioners
resource "null_resource" "sync_app1_static" {
  depends_on = [ time_sleep.wait_90_seconds ]
  triggers = {
    always-update =  timestamp()
  }

  # Connection Block for Provisioners to connect to EC2 Instance
  connection {
    type = "ssh"
    host = aws_instance.my-ec2-vm.public_ip 
    user = "ec2-user"
    password = ""
    private_key = file("~/mydev/creds/terraform-key.pem")
  }  

 # Copies the app1 folder to /tmp
  provisioner "file" {
    source      = "apps/app1"
    destination = "/tmp"
  }

# Copies the /tmp/app1 folder to Apache Webserver /var/www/html directory
  provisioner "remote-exec" {
    inline = [
      "sudo cp -r /tmp/app1 /var/www/html"
    ]
  }
}
