
output "invoke_url" {
  value = "${aws_api_gateway_deployment.stage.invoke_url}/catalog/products"
}
