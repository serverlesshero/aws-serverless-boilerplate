output "lambda_function_url" {
  description = "Function URL of the Lambda."
  value       = aws_lambda_function_url.function_url.function_url
}
