
#creating aws instance of Amazon Linux 2. 
resource "aws_instance" "web" {
  ami                 = var.aws_amis[var.AWS_REGION]
  instance_type       = "t2.micro"
  availability_zone   = element(var.instance_azs, count.index +1)
  vpc_security_group_ids = [aws_security_group.web-ssh-http.id]
  key_name            = aws_key_pair.mykey.key_name
  count               = var.instance_count
  user_data = <<-EOF
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
  EOF
#this is inline EBS which is defined inside of aws_instance block
  ebs_block_device {
    device_name           = "/dev/xvda"
    volume_size           = 20
    volume_type           = "gp2"
    delete_on_termination = true
    encrypted             = false
    #snapshot_id          = "snap-084cb269d55295d27"  
  }

  tags = {
     #Name  = "web-${count.index + 1}"
     #Name = "${format("web-%03d", count.index + 1)}"          # web-001, web-002, web-003
     Name = "${element(var.instance_tags, count.index +1)}"  #name=production, name= testing, name = development"
     Team = "AWS-Architect-Team"
     OS = "Amazon-Linux2"
  }
}

