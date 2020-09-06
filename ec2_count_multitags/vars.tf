#Access keys are defined here but not value not assigned
#values are assigned in terraform.tfvars file.
variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
  default = "us-east-1"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

# AmazonLinux 2 AMI list 
variable "aws_amis" {
  default = {
    "us-east-1" = "ami-00dc79254d0461090"
    "us-west-1" = "ami-3f75767a"
    "us-west-2" = "ami-21f78e11"
  }
}

variable "instance_count" {
  default = "3"
}

variable "instance_tags" {
  type = list
  default = ["Production", "Development", "Testing"]
}
