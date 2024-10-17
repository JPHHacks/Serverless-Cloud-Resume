resource "aws_lambda_function" "tfer--IncrementWebsiteViewCount" {
  architectures = ["x86_64"]

  ephemeral_storage {
    size = "512"
  }

  function_name                  = "IncrementWebsiteViewCount"
  handler                        = "lambda_function.lambda_handler"
  memory_size                    = "128"
  package_type                   = "Zip"
  reserved_concurrent_executions = "-1"
  role                           = "arn:aws:iam::329599633980:role/service-role/IncrementWebsiteViewCount-role-lmv5hj6w"
  runtime                        = "python3.12"
  skip_destroy                   = "false"
  source_code_hash               = "HJw+kA1cLzwyQybTdamxg5UlePbDXGCfJz7BNkSMNIc="
  timeout                        = "3"

  tracing_config {
    mode = "PassThrough"
  }
}
