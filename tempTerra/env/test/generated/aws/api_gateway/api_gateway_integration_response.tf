resource "aws_api_gateway_integration_response" "tfer--oqk7dmd9p0-002F-mad144bnq2-002F-GET-002F-200" {
  http_method = "GET"
  resource_id = "mad144bnq2"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  rest_api_id = "oqk7dmd9p0"
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "tfer--oqk7dmd9p0-002F-mad144bnq2-002F-OPTIONS-002F-200" {
  http_method = "OPTIONS"
  resource_id = "mad144bnq2"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  rest_api_id = "oqk7dmd9p0"
  status_code = "200"
}
