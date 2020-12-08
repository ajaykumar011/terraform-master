
terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  region     = var.AWS_REGION
}

resource "aws_s3_bucket" "log-bucket" {
  bucket = "mybucket0114956-log"
  acl = "log-delivery-write"
}

resource "aws_s3_bucket" "b" {
  bucket = "mybucket-c29df1xy"
  acl    = "private"
  versioning {
    enabled = true
  }
  logging { 
    target_bucket = aws_s3_bucket.log-bucket.id
  }

  tags = {
    Name = "mybucket-c29df1xy"
  }
}

output "bucket" {
  value = aws_s3_bucket.b.bucket_domain_name
}

