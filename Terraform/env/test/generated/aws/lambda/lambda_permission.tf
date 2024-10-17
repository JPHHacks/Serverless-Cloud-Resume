resource "aws_lambda_permission" "tfer--4f60fcc9-cd93-59b4-8bd3-72143783feb4" {
  action        = "lambda:InvokeFunction"
  function_name = "arn:aws:lambda:us-east-1:329599633980:function:IncrementWebsiteViewCount"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:us-east-1:329599633980:oqk7dmd9p0/*/GET/"
  statement_id  = "4f60fcc9-cd93-59b4-8bd3-72143783feb4"
}
