resource "aws_launch_configuration" "app-launchconfig" {
  name_prefix     = "app-launchconfig"
  image_id        = var.APP_AMI
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.mykey.key_name
  security_groups = [aws_security_group.myinstance.id]
  user_data       = "#!/bin/bash\napt-get update\napt-get -y install net-tools"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "app-autoscaling" {
  name                      = "app-autoscaling"
  vpc_zone_identifier       = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]
  launch_configuration      = aws_launch_configuration.app-launchconfig.name
  min_size                  = 2
  max_size                  = 4
  health_check_grace_period = 300
  health_check_type         = "ELB"  #this is important 
  load_balancers            = [module.alb.this_lb_id]   #resource_type.resource_name.name_attribute(object)
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "ec2 instance"
    propagate_at_launch = true
  }
}

#Other methods (except ab tools) to increase CPU Load
# $ sudo apt-get update && sudo apt-get install stress
# $ sudo stress --cpu 2 --timeout 600
