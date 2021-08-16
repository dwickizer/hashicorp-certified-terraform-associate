# Create EC2 Instnace Resource
resource "aws_instance" "myec2vm" {
  ami = "ami-0645cf757ebd107e5"
  availability_zone = "us-gov-west-1a"
  count = 1
  instance_type = "t2.micro"
  key_name = "terraform-key"
  iam_instance_profile = "jumphost-ec2-role"
  subnet_id = "subnet-0fdddb2e4bc7709b1"
  vpc_security_group_ids = [ "sg-01143bdb99ee641bc" ]
  tags = {
    "Name": "lbi-jumphost"
    "Environment": "Dev"
    "Owner": "dwickizer"
  }

}
