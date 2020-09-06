output "instance_public_ip" {
  value = aws_instance.web-server.public_ip
}

output "instance_public_dns" {
    value = aws_instance.web-server.public_dns
}

output "instance_key" {
    value = aws_instance.web-server.key_name
}
