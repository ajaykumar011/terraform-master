
terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  region     = var.AWS_REGION
}
resource "random_string" "random" {
  length = 16
  special = true
  upper = false
  override_special = "-"
}


resource "aws_s3_bucket" "b" {
  bucket = random_string.random.result
  tags = {
    Name = random_string.random.result
  }
}


resource "random_id" "server" {
  byte_length = 8
}

resource "aws_s3_bucket" "c" {
  bucket = "cloudzone-${random_id.server.hex}"
  tags = {
    Name = "cloudzone-${random_id.server.hex}"
  }
}

output "bucket1" {
  value = aws_s3_bucket.b.bucket_domain_name
}

output "bucket2" {
  value = aws_s3_bucket.c.bucket_domain_name
}
