resource "aws_api_gateway_rest_api" "website_view_counter_api" {
  name        = "WebsiteViewCounterAPI"
  description = "API for incrementing website view count"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_method" "get" {
  rest_api_id   = aws_api_gateway_rest_api.website_view_counter_api.id
  resource_id   = aws_api_gateway_rest_api.website_view_counter_api.root_resource_id
  http_method   = "GET"
  authorization = "NONE"  # No authorization for public access
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.website_view_counter_api.id
  resource_id             = aws_api_gateway_rest_api.website_view_counter_api.root_resource_id
  http_method             = aws_api_gateway_method.get.http_method
  integration_http_method = "POST"  # Lambda integration uses POST
  type                    = "AWS"     # Use AWS integration (not proxy)
  uri                     = var.lambda_invoke_arn  # ARN for the Lambda function
}

resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id = aws_api_gateway_rest_api.website_view_counter_api.id
  resource_id = aws_api_gateway_rest_api.website_view_counter_api.root_resource_id
  http_method = aws_api_gateway_method.get.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true  # Allow CORS for all origins
  }
}

resource "aws_api_gateway_integration_response" "lambda_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.website_view_counter_api.id
  resource_id = aws_api_gateway_rest_api.website_view_counter_api.root_resource_id
  http_method = aws_api_gateway_method.get.http_method
  status_code = aws_api_gateway_method_response.response_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"  # Allow CORS for all origins
  }

  depends_on = [aws_api_gateway_integration.lambda_integration]
}

resource "aws_api_gateway_method" "options" {
  rest_api_id   = aws_api_gateway_rest_api.website_view_counter_api.id
  resource_id   = aws_api_gateway_rest_api.website_view_counter_api.root_resource_id
  http_method   = "OPTIONS"
  authorization = "NONE"  # No authorization for public access
}

resource "aws_api_gateway_integration" "options_integration" {
  rest_api_id             = aws_api_gateway_rest_api.website_view_counter_api.id
  resource_id             = aws_api_gateway_rest_api.website_view_counter_api.root_resource_id
  http_method             = aws_api_gateway_method.options.http_method
  type                    = "MOCK"  # Use MOCK for OPTIONS
  connection_type         = "INTERNET"
  passthrough_behavior    = "WHEN_NO_MATCH"
  request_templates = {
    "application/json" = "{\"statusCode\": 200}"  # Return a 200 status code for OPTIONS
  }
}

resource "aws_api_gateway_method_response" "options_response" {
  rest_api_id = aws_api_gateway_rest_api.website_view_counter_api.id
  resource_id = aws_api_gateway_rest_api.website_view_counter_api.root_resource_id
  http_method = aws_api_gateway_method.options.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "true"
    "method.response.header.Access-Control-Allow-Methods" = "true"
    "method.response.header.Access-Control-Allow-Headers" = "true"
  }
}

resource "aws_api_gateway_integration_response" "options_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.website_view_counter_api.id
  resource_id = aws_api_gateway_rest_api.website_view_counter_api.root_resource_id
  http_method = aws_api_gateway_method.options.http_method
  status_code = aws_api_gateway_method_response.options_response.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'"
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
  }
}

resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.website_view_counter_api.id

  depends_on = [
    aws_api_gateway_method.get,
    aws_api_gateway_method.options,
    aws_api_gateway_integration.lambda_integration,
    aws_api_gateway_integration.options_integration
  ]
}

# Creates a Stage for the API
resource "aws_api_gateway_stage" "stage" {
  rest_api_id = aws_api_gateway_rest_api.website_view_counter_api.id
  stage_name  = var.environment  
  deployment_id = aws_api_gateway_deployment.deployment.id
}

# Creates a Usage Plan for rate limiting
resource "aws_api_gateway_usage_plan" "website_view_counter_usage_plan" {
  name        = "WebsiteViewCounterUsagePlan"
  description = "Usage plan for the Website View Counter API"
  
  api_stages {
    api_id = aws_api_gateway_rest_api.website_view_counter_api.id
    stage  = aws_api_gateway_stage.stage.id  # Reference the created stage
  }

  # Sets the rate and burst limits
  throttle_settings {
    burst_limit = 200
    rate_limit  = 100
  }
}

resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name  
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.website_view_counter_api.execution_arn}/*/*"  # Allow all methods and resources
}