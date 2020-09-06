variable "region" {
  type    = string
  default = "us-east-1"
}
variable "ami_id" {
  type = map
  default = {
    us-east-1    = "ami-00dc79254d0461090"
    eu-west-2    = "ami-132b3c7efe6sdfdsfd"
    eu-central-1 = "ami-9787h5h6nsn75gd33"
  }
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
#This key is already exists on the EC2
variable "key_name" {
  type    = string
  default = "ec2-demo"
}
