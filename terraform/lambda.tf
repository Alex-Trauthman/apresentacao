resource "aws_lambda_function" "lambda" {
  filename      = var.filename
  function_name = var.lambda_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = var.handler

  source_code_hash = var.hash == null ? filebase64sha256(var.filename) : var.hash

  runtime                        = var.runtime
  timeout                        = var.timeout
  memory_size                    = var.memory_size
  reserved_concurrent_executions = var.reserved_concurrent_executions

  environment {
    variables = {
      DYNAMODB_TABLE = var.dynamodb_name
    }
  }
}
resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.this.execution_arn}/*/*"
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "${var.lambda_name}-role"
  assume_role_policy = var.assume_role_policy
}

resource "aws_iam_role_policy_attachment" "lambda_dynamodb_access" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.dynamodb_access.arn
}

resource "aws_iam_policy" "dynamodb_access" {
  name        = "${var.lambda_name}-role"
  description = "Allows the Lambda function to perform CRUD operations on the DynamoDB table"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Scan"
        ],
        Resource = aws_dynamodb_table.this.arn
      }
    ]
  })
}