# A simple 3 lines code to create an instance
resource "aws_instance" "web1" {
   ami           = lookup(var.ami_id, var.region)
   instance_type = "t2.micro"
 }
