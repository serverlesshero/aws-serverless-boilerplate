# Define the Lambda function
resource "aws_lambda_function" "lambda" {
  s3_bucket        = var.s3_bucket_name
  s3_key           = var.s3_key
  function_name    = var.function_name
  source_code_hash = data.aws_s3_object.package.etag
  role             = aws_iam_role.lambda_role.arn
  handler          = var.function_handler
  runtime          = var.runtime
  depends_on = [
    aws_iam_role_policy_attachment.lambda_policy_attachment,
    aws_iam_role.lambda_role
  ]
}

data "aws_s3_object" "package" {
  bucket = var.s3_bucket_name
  key    = var.s3_key
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda-role" # Change to your desired role name
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
  function_name      = aws_lambda_function.lambda.arn
  authorization_type = "NONE"
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_role.name
}
