resource "aws_s3_bucket" "s3_bucket" {
  bucket = "serverlesshero-backend"
  tags = {
    Name = "serverlesshero-backend"
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket" "s3_bucket_for_releases" {
  bucket = "serverlesshero-releases"
  tags = {
    Name = "serverlesshero-releases"
  }
  lifecycle {
    prevent_destroy = true
  }
}
