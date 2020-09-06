variable "region" {
  type    = string
  default = "us-east-1"
}
variable "ami_id" {
  type = map
  default = {
    us-east-1    = "ami-00dc79254d0461090"
  }
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}