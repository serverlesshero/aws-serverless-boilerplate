resource "aws_api_gateway_rest_api" "rest_api" {
  name = var.rest_api_name
}

resource "aws_api_gateway_resource" "api_resource_proxy" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_rest_api.rest_api.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "api_method_proxy" {
  api_key_required = false
  rest_api_id      = aws_api_gateway_rest_api.rest_api.id
  resource_id      = aws_api_gateway_resource.api_resource_proxy.id
  http_method      = "ANY"
  authorization    = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
  depends_on = [
    aws_api_gateway_resource.api_resource_proxy
  ]
}

resource "aws_api_gateway_integration" "proxy_integration" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.api_resource_proxy.id
  http_method             = aws_api_gateway_method.api_method_proxy.http_method
  type                    = "AWS_PROXY"
  uri                     = var.lambda_invoke_arn
  integration_http_method = "POST"
}


resource "aws_api_gateway_deployment" "stage" {
  depends_on = [
    aws_api_gateway_integration.proxy_integration
  ]
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  stage_name  = "dev"
}

resource "random_uuid" "statement_id" {
}

resource "aws_lambda_permission" "api_gw" {
  action        = "lambda:InvokeFunction"
  statement_id  = random_uuid.statement_id.result
  function_name = var.lambda_arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.rest_api.execution_arn}/*/*/*"
}
