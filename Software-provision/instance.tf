
resource "aws_instance" "web-server" {
  ami           = lookup(var.ami_id, var.region)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
#above keyfile points to resource key.tf and key.tf points to variables.tf and variables.tf shows the key name 

#Provisioners are used for executing scripts or shell commands on a local or remote machine as part of resource creation/deletion. 
#They are similar to “EC2 instance user data” scripts that only run once on the creation and if it fails terraform marks it tainted.


#The file provisioner is used to copy files or directories from the machine executing Terraform to the newly created resource. 
#The file provisioner supports both ssh and winrm type connections.
 
  provisioner "file" {
    source      = "index.html"
    destination = "/tmp/index.html"
  }
  provisioner "remote-exec" {
      inline = [
        "sudo yum install -y httpd; sudo cp /tmp/index.html /var/www/html/",
        "sudo service httpd restart",
        "sudo service httpd status"
      ]
    }
  
  #coalesce takes any number of arguments and returns the first one that isn't null or an empty string
  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }
}
