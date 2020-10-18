resource "aws_iam_role" "app-s3-role" {
  name = "app-s3-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = {
      tag-key = "tag-value"
  }
}

resource "aws_iam_role_policy" "app-s3-policy" {
  name = "app-s3-policy"
  role = aws_iam_role.app-s3-role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_instance_profile" "app-ec2-role" {
  name = "app-ec2-role"
  role = aws_iam_role.app-s3-role.name
}


