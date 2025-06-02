resource "aws_api_gateway_rest_api" "this" {
  name        = var.name_api
  description = "API Gateway for Lambda"
}

resource "aws_api_gateway_resource" "lambda_resource" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "lambda"
}

resource "aws_api_gateway_method" "lambda_method" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.lambda_resource.id
  http_method   = var.http_method
  authorization = "NONE"
}
resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.lambda_resource.id
  http_method = aws_api_gateway_method.lambda_method.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "lambda_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.lambda_resource.id
  http_method = aws_api_gateway_method.lambda_method.http_method
  status_code = aws_api_gateway_method_response.response_200.status_code

  response_templates = {
    "application/json" = "$input.json('$')"
  }
}
resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.lambda_resource.id
  http_method             = aws_api_gateway_method.lambda_method.http_method
  type                    = "AWS" # Integração não-proxy
  integration_http_method = "POST"
  uri                     = aws_lambda_function.lambda.invoke_arn

  request_parameters = {
    "integration.request.header.X-Authorization" = "'static'"
  }

  request_templates = {
    "application/json" = <<EOF
    {
      "operation": $input.json('$.operation'),
      "payload": $input.json('$.payload')
    }
    EOF
  }
}