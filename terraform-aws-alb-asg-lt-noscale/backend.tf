terraform {
  backend "s3" {
    bucket = "cloudzone100"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
