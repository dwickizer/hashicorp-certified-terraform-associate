# Create S3 Bucket Resource
resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
  # acl    = "public-read"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AnonymousReadOnlyFromMitreNetwork",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws-us-gov:s3:::${var.bucket_name}/*",
            "Condition": {
                "IpAddress": {
                    "aws:SourceIp": [
                        "192.80.55.64/27",
                        "192.160.51.64/27",
                        "128.29.0.0/16",
                        "129.83.0.0/16"
                    ]
                }
            }
        }
    ]
}
EOF
website {
    index_document = "index.html"
    error_document = "error.html"
  }
  tags          = var.tags

  # This allows the bucket to automatically destroyed without manually clearing it out first
  force_destroy = true
}

# Automatically upload index.html file
resource "aws_s3_bucket_object" "object" {
  bucket = var.bucket_name
  key    = "index.html"
  source = "index.html"
}
