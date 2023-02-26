terraform {
  backend "s3" {
    bucket         = "serverlesshero-backend"
    key            = "dotnet-aws-serverless/dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-locks"
  }
}
