#instance resource
resource "aws_instance" "ec2_lamp" {
  ami           = lookup(var.ami_id, var.region)
  instance_type = var.instance_type
  # Security group assign to instance
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  # Using personal key name 
  # ssh-keygen -f mykey (if you have not copied key from other directory)
  key_name      = aws_key_pair.mykey.key_name

  user_data = <<EOF
		#! /bin/bash
     
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

	   EOF

  tags = {
    Name = "Ec2-User-data"
  }
}
