output "instance_public_ip" {
  value = aws_instance.ec2_lamp.public_ip
}

output "instance_public_dns" {
    value = aws_instance.ec2_lamp.public_dns
}

output "instance_key" {
    value = aws_instance.ec2_lamp.key_name
}

