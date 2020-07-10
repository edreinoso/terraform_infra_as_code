#! /bin/bash
sudo yum update -y
sudo yum install -y httpd 
sudo systemctl start httpd 
sudo systemctl enable httpd
echo "<h1>Hello Terraform - Template 2</h1><h2>Deploying LAMP stack infrastructure</h2>" | sudo tee /var/www/html/index.html