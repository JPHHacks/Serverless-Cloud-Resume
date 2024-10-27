resource "aws_dynamodb_table" "website_view_counter" {
  name           = var.table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "ID"

  attribute {
    name = "ID"
    type = "S"
  }

  point_in_time_recovery {
    enabled = false
  }

  table_class = "STANDARD"

  tags = {
    Environment = var.environment
  }
}