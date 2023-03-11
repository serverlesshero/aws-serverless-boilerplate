
variable "rest_api_name" {
  type        = string
  description = "Name of the API Gateway created"
}

variable "lambda_invoke_arn" {
  type = string
}

variable "lambda_arn" {
  type = string
}

variable "lambda_function_name" {
  type = string
}
