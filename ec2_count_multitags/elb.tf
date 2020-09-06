
#ELB
resource "aws_elb" "web" {
  name = "terraform-example-elb"

  # The same availability zone as our instances
  availability_zones = aws_instance.web.*.availability_zone

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }
  cross_zone_load_balancing   = true  #distribute traffic across zones
  connection_draining         = true
  connection_draining_timeout = 400    #seconds to drain all active connections before termination of instance
  tags = {
    Name = "my-elb"
  }
  # The instances are registered automatically
  instances = aws_instance.web.*.id
}
