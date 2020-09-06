output instance_ids {
  description = "IDs of EC2 instances"
  # value       = [aws_instance.web_a.id, aws_instance.web_b.id]
  value       = aws_instance.web.*.id
}

# output "first-address" {
#   value = "Instances: ${element(aws_instance.web.*.id, 0)}"
# }


output instance-tags {
#value = "${element(aws_instance.web.*.tags, "Name")}"
value = aws_instance.web.*.tags
}