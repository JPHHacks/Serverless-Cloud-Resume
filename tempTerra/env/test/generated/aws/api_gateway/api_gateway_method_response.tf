resource "aws_api_gateway_method_response" "tfer--oqk7dmd9p0-002F-mad144bnq2-002F-GET-002F-200" {
  http_method = "GET"
  resource_id = "mad144bnq2"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "false"
  }

  rest_api_id = "oqk7dmd9p0"
  status_code = "200"
}

resource "aws_api_gateway_method_response" "tfer--oqk7dmd9p0-002F-mad144bnq2-002F-OPTIONS-002F-200" {
  http_method = "OPTIONS"
  resource_id = "mad144bnq2"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "false"
    "method.response.header.Access-Control-Allow-Methods" = "false"
    "method.response.header.Access-Control-Allow-Origin"  = "false"
  }

  rest_api_id = "oqk7dmd9p0"
  status_code = "200"
}
