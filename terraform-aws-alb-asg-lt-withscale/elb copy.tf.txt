module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 5.0"
  
  name = "app-alb"

  load_balancer_type = "application"

  vpc_id             = aws_vpc.main.id
  subnets            = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]
  security_groups    = [aws_security_group.elb-securitygroup.id]
  
  // access_logs = {
  //   bucket = aws_s3_bucket.elblogs-store.id
  // }

  target_groups = [
    {
      name_prefix      = "pref-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
    }
  ]

  // https_listeners = [
  //   {
  //     port               = 443
  //     protocol           = "HTTPS"
  //     certificate_arn    = "arn:aws:iam::123456789012:server-certificate/test_cert-123456789012"
  //     target_group_index = 0
  //   }
  // ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Environment = "Test"
  }
}