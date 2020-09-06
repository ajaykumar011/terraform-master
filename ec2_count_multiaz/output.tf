output instance_ids {
  description = "IDs of EC2 instances"
  # value       = [aws_instance.web_a.id, aws_instance.web_b.id]
  value       = aws_instance.web.*.id
}

output instance_azs {
  description = "IDs of EC2 instances"
  # value       = [aws_instance.web_a.id, aws_instance.web_b.id]
  value       = aws_instance.web.*.availability_zone
}


# output "first-address" {
#   value = "Instances: ${element(aws_instance.web.*.id, 0)}"
# }

output instance-tags {
  #value = "${element(aws_instance.web.*.tags, "Name")}"
  value = aws_instance.web.*.tags
}

output "instance_ip_addr" {
  value       = aws_instance.web.*.public_ip
  description = "The Public IP address of the main server instance."
}

output "instance_dns_addr" {
  value       = aws_instance.web.*.public_dns
  description = "The Public DNS address of the main server instance."
}
