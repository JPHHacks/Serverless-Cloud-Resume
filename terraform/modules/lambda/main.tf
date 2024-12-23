data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/lambda_code"  
  output_path = "${path.module}/lambda_function.zip"  
}

resource "aws_lambda_function" "website_view_counter" {
  function_name = var.function_name
  handler       = "lambda_function.lambda_handler"
  role          = aws_iam_role.lambda_exec.arn
  runtime       = "python3.12"

  architectures = ["x86_64"]
  memory_size   = 128
  timeout       = 3

  # Uses the output from the archive_file data source
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  tracing_config {
    mode = "PassThrough"
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_iam_role" "lambda_exec" {
  name = "${var.function_name}-role-${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

