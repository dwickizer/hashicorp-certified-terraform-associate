# Resource Block: Create Random Pet Name 

# Resource Block: Create AWS S3 Bucket
resource "aws_s3_bucket" "terraform-backend" {
  bucket = "terraform-backend-dw"
  acl = "private"
  
  versioning {
    enabled = true
  }

  tags = {
    Owner = "dwickizer"
  }
}

resource "aws_s3_bucket_object" "dev-folder" {
  bucket = aws_s3_bucket.terraform-backend.id
  key = "dev/terraform.tfstate"
}

