# DynamoDB table for Terraform state locking
resource "aws_dynamodb_table" "terraform-dev-state-table" {
    name = "terraform-dev-state-table"
    hash_key = "LockID"
    attribute {
      name = "LockID"
      type = "S"
    }
    depends_on = [
      aws_s3_bucket.terraform-backend
    ]
    billing_mode = "PROVISIONED"
    write_capacity = 5
    read_capacity = 5
    tags = {
      "Owner" = "dwickizer"
    }
}