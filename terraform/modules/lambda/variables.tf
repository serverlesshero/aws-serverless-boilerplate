variable "function_name" {
  type = string
}

variable "function_handler" {
  type = string
}

variable "s3_bucket_name" {
  type = string
}

variable "s3_key" {
  type = string
}

variable "runtime" {
  type = string
}

variable "enable_function_url" {
  type    = bool
  default = false
}

variable "timeout_in_seconds" {
  type    = number
  default = 150
}
