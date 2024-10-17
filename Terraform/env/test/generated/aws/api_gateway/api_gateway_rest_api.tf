resource "aws_api_gateway_rest_api" "tfer--oqk7dmd9p0_WebsiteViewCounterAPI" {
  api_key_source               = "HEADER"
  disable_execute_api_endpoint = "false"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  minimum_compression_size = "-1"
  name                     = "WebsiteViewCounterAPI"
}
