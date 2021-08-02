# Create EC2 Instance
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance

resource "aws_instance" "my-ec2-vm" {
  ami               = "ami-0645cf757ebd107e5"
  instance_type     = "t2.micro"
  # availability_zone = "us-gov-west-1b"
  subnet_id = "subnet-0a4220540eb21458b"
  
  tags = {
    "Name" = "web"   
    "Owner" = "dwickizer"
    "tag1" = "Update-test-1" 
  }
}
