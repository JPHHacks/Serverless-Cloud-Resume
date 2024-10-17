resource "aws_api_gateway_integration" "tfer--oqk7dmd9p0-002F-mad144bnq2-002F-GET" {
  cache_namespace         = "mad144bnq2"
  connection_type         = "INTERNET"
  content_handling        = "CONVERT_TO_TEXT"
  http_method             = "GET"
  integration_http_method = "POST"
  passthrough_behavior    = "WHEN_NO_MATCH"
  resource_id             = "mad144bnq2"
  rest_api_id             = "oqk7dmd9p0"
  timeout_milliseconds    = "29000"
  type                    = "AWS"
  uri                     = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:329599633980:function:IncrementWebsiteViewCount/invocations"
}

resource "aws_api_gateway_integration" "tfer--oqk7dmd9p0-002F-mad144bnq2-002F-OPTIONS" {
  cache_namespace      = "mad144bnq2"
  connection_type      = "INTERNET"
  http_method          = "OPTIONS"
  passthrough_behavior = "WHEN_NO_MATCH"

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }

  resource_id          = "mad144bnq2"
  rest_api_id          = "oqk7dmd9p0"
  timeout_milliseconds = "29000"
  type                 = "MOCK"
}
