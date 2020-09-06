provider "aws" {
  region     = var.region
  version    = "~> 2.0"
}

resource "aws_instance" "ebs_instance_example" {
  ami           = lookup(var.ami_id, var.region)              # lookup ami from variables map
  instance_type = var.instance_type                           # instance type from variables.tf
  subnet_id     = aws_subnet.public_1.id                      # aws_subnet is the name of subnet from vpc.tf file

  # Security group assign to instance
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]  #Security group from security_group.tf , we can defined multiple SGs.

  # key name
  key_name = var.key_name                   # ready made keys already exists keys.
  # User data passing through template rendering
  user_data = data.template_file.init.rendered

  tags = {
    Name = "EBS with userdata"
  }
}
