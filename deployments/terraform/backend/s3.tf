resource "aws_s3_bucket" "s3_bucket" {
  bucket = "serverlesshero-backend"
  tags = {
    Name = "serverlesshero-backend"
  }
  lifecycle {
    prevent_destroy = true
  }
}
