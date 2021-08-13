#! /bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo service httpd start  
sudo systemctl enable httpd
sudo echo "<h1>Hostname: $HOSTNAME</h1>" > /var/www/html/index.html
REGION=`echo $HOSTNAME | cut -d. -f2`
sudo echo "<h1>Welcome to C2DM created using Terraform in $REGION Region</h1>" >> /var/www/html/index.html