
terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  region     = var.AWS_REGION
}


resource "aws_s3_bucket" "b" {
  bucket = "cloudzone-bucket99"
    versioning {
    enabled = true
  }

  tags = {
    Name = "mybucket-c29df1xy"
  }
}

resource "aws_s3_bucket_policy" "b" {
  bucket = aws_s3_bucket.b.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "MYBUCKETPOLICY",
  "Statement": [
    {
      "Sid": "IPAllow",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::cloudzone-bucket99/*",
      "Condition": {
         "IpAddress": {"aws:SourceIp": "8.8.8.8/32"}
      }
    }
  ]
}
POLICY
}

output "bucket" {
  value = aws_s3_bucket.b.bucket_domain_name
}

