resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  tags   = var.bucket_tags
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
