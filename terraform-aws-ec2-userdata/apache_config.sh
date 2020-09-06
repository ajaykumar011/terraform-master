#!/bin/bash
yum update -y
amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
yum install -y httpd mariadb-server git
systemctl start httpd
systemctl enable httpd
usermod -a -G apache ec2-user
git clone https://github.com/ajaykumar011/cloudformation_files.git /var/www/html/
chown -R ec2-user:apache /var/www
chmod 2775 /var/www
find /var/www -type d -exec chmod 2775 {} \;
find /var/www -type f -exec chmod 0664 {} \;
echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php
systemctl restart httpd
