output "instance_public_ip" {
  value = aws_instance.ebs_instance_example.public_ip
}

output "instance_public_dns" {
    value = aws_instance.ebs_instance_example.public_dns
}

output "instance_key" {
    value = aws_instance.ebs_instance_example.key
}

output "tags" {
    description = "List of tags of the APP and DB instances"
    value       = [aws_instance.ebs_instance_example.*.tags.Name,
               aws_instance.ebs_instance_example.*.tags.Name]
}

output "ebs_voltype" {
    value = aws_ebs_volume.ebs_volume.type
}

output "ebs_volsize" {
    value = aws_ebs_volume.ebs_volume.size
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = concat(aws_vpc.vpc_demo.*.id, [""])[0]
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = concat(aws_vpc.vpc_demo.*.arn, [""])[0]
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = concat(aws_vpc.vpc_demo.*.cidr_block, [""])[0]
}
