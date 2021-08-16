# Create S3 Bucket
resource "aws_s3_bucket" "mybucket" {
  bucket = "tf-import"
  # force_destroy = "false"
  # acl = "private"
  tags = {
    Environment = "Dev"
    Owner = "dwickizer"
  }
}

# terraform import aws_s3_bucket.mybucket state-import-bucket