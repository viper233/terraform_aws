resource "aws_s3_bucket" "project2023_24_tfstate_viper233" {
  bucket = "project2023-24-tfstate-viper233"
}

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.project2023_24_tfstate_viper233.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "project2023_24_tfstate_viper233" {
  bucket = aws_s3_bucket.project2023_24_tfstate_viper233.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "project2023_24_tfstate_viper233" {
  bucket = aws_s3_bucket.project2023_24_tfstate_viper233.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name = "terraform-state-lock"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }
}
