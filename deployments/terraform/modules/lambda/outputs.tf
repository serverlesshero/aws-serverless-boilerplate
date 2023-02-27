output "lambda_function_url" {
  description = "Function URL of the Lambda."
  value       = var.enable_function_url ? aws_lambda_function_url.function_url[0].function_url : null
}
