data "aws_lambda_function" "lambda_login" {
  function_name = "lambda_vdlg_login"
}

resource "aws_api_gateway_resource" "resource_lambda_login" {
  rest_api_id = aws_api_gateway_rest_api.rest_api_login.id
  parent_id   = aws_api_gateway_rest_api.rest_api_login.root_resource_id
  path_part   = "login"
  depends_on = [
    aws_api_gateway_rest_api.rest_api_login
  ]
}

resource "aws_api_gateway_method" "method_lambda_login" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api_login.id
  resource_id   = aws_api_gateway_resource.resource_lambda_login.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration_lambda_login" {
  rest_api_id = aws_api_gateway_rest_api.rest_api_login.id
  resource_id = aws_api_gateway_resource.resource_lambda_login.id
  http_method = aws_api_gateway_method.method_lambda_login.http_method
  integration_http_method = "POST"
  type        = "AWS_PROXY"
  uri         = data.aws_lambda_function.lambda_login.invoke_arn
}

resource "aws_lambda_permission" "permission_lambda_login" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.aws_lambda_function.lambda_login.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.rest_api_login.execution_arn}/*/*/*"
  depends_on = [
    aws_api_gateway_rest_api.rest_api_login,
  ]
}