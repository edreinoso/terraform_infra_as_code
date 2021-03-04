#! /bin/bash
sudo yum update -y
sudo amazon-linux-extras install -y epel lamp-mariadb10.2-php7.2 php7.2
sudo yum install -y stress httpd mariadb-server
# enabling just the http server
sudo systemctl start httpd 
sudo systemctl enable httpd
echo "<h1>Hello Terraform - Template 2</h1>" | sudo tee /var/www/html/index.html