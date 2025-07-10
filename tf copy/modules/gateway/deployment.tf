resource "aws_api_gateway_deployment" "deployment_login" {
  rest_api_id = aws_api_gateway_rest_api.rest_api_login.id

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_api_gateway_integration.integration_lambda_login,
  ]
}

resource "aws_api_gateway_stage" "stage_login" {
  deployment_id = aws_api_gateway_deployment.deployment_login.id
  rest_api_id   = aws_api_gateway_rest_api.rest_api_login.id
  stage_name    = "dev"
}

  resource "aws_api_gateway_deployment" "deployment_app" {
  rest_api_id = aws_api_gateway_rest_api.rest_api_app.id

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_api_gateway_integration.proxy,
  ]
}

resource "aws_api_gateway_stage" "stage_app" {
  deployment_id = aws_api_gateway_deployment.deployment_app.id
  rest_api_id   = aws_api_gateway_rest_api.rest_api_app.id
  stage_name    = "dev"
}