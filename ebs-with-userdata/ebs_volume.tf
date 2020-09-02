#EBS resource
resource "aws_ebs_volume" "ebs_volume" {
  availability_zone = "us-east-1a"
  size              = var.ebs_size                                      # defined in variables.tf
  type              = "gp2"

  tags = {
    Name = "ebs-volume-terraform-demo"
  }
}

#Volume attachment resource
resource "aws_volume_attachment" "ebc_volume_attachment" {
  device_name = var.device_name                                         # value /dev/xvdh from variables.tf
  volume_id   = aws_ebs_volume.ebs_volume.id                            # this id is generated from above EBS resource
  instance_id = aws_instance.ebs_instance_example.id                    # Instance Id to link. Id id generated from instance.tf 
  force_detach = true
}

data "template_file" "init" {  #This template named 'init' is to be used with instance user-data
  template = file("volume.sh")

  vars = {
    device_name = var.device_name   # variable form variables.tf - /dev/xvdh
  }
}
