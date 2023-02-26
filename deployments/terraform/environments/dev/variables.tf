variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "common_tags" {
  default = {
    Environment = "dev"
    Owner       = "Mukesh Murugan"
    Project     = "serverlesshero/dotnet-aws-serverless"
  }
  type = map(string)
}
