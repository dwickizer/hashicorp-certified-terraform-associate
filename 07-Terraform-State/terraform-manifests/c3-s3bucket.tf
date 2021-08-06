

# Resource Block: Create AWS S3 Bucket for Terraform Backend
resource "aws_s3_bucket" "terraform-backend" {
  bucket = "terraform-backend-dw"
  
  versioning {
    enabled = true
  }

  tags = {
    Owner = "dwickizer"
  }
}

# Creating the first key lets terraform delete the bucket, even with 
# later versions of that key
resource "aws_s3_bucket_object" "dev-folder" {
  bucket = aws_s3_bucket.terraform-backend.id
  key = "dev/terraform.tfstate"
}

