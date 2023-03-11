output "lambda_function_url" {
  description = "Function URL of the Lambda."
  value       = var.enable_function_url ? aws_lambda_function_url.function_url[0].function_url : null
}

output "lambda_invoke_arn" {
  description = "Lambda Invoke ARN."
  value       = aws_lambda_function.lambda.invoke_arn
}

output "lambda_arn" {
  description = "Lambda ARN."
  value       = aws_lambda_function.lambda.arn
}


output "lambda_function_name" {
  description = "Lambda Function Name."
  value       = aws_lambda_function.lambda.function_name
}
