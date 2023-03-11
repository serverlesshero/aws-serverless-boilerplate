# issue https://github.com/hashicorp/terraform-provider-aws/issues/29921
resource "aws_lambda_function" "lambda" {
  s3_bucket        = data.aws_s3_object.package.bucket
  s3_key           = data.aws_s3_object.package.key
  source_code_hash = data.aws_s3_object.package.etag
  function_name    = var.function_name
  role             = aws_iam_role.lambda_role.arn
  handler          = var.function_handler
  runtime          = var.runtime
  timeout          = var.timeout_in_seconds
  depends_on = [
    aws_iam_role_policy_attachment.lambda_policy_attachment,
    aws_iam_role.lambda_role,
    data.aws_s3_object.package
  ]

  environment {
    variables = {
      ASPNETCORE_ENVIRONMENT = "Development"
    }
  }
}

data "aws_s3_object" "package" {
  bucket = var.s3_bucket_name
  key    = var.s3_key
}

resource "aws_iam_role" "lambda_role" {
  name = "${var.function_name}-lambda-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}
resource "aws_lambda_function_url" "function_url" {
  count              = var.enable_function_url ? 1 : 0
  function_name      = aws_lambda_function.lambda.arn
  authorization_type = "NONE"
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_role.name
}

resource "aws_iam_role_policy_attachment" "lambda" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
  role       = aws_iam_role.lambda_role.name
}
