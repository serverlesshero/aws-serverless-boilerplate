# Define the Lambda function
resource "aws_lambda_function" "lambda" {
  s3_bucket     = "serverlesshero-releases"
  s3_key        = "lambdas/catalog-latest.zip"
  function_name = var.function_name
  role          = aws_iam_role.lambda_role.arn
  handler       = var.function_handler
  runtime       = var.runtime
  depends_on = [
    aws_iam_role_policy_attachment.lambda_policy_attachment,
    aws_iam_role.lambda_role
  ]
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

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_role.name
}
