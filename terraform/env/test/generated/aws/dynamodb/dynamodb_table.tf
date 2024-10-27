resource "aws_dynamodb_table" "tfer--WebsiteViewCounter" {
  attribute {
    name = "ID"
    type = "S"
  }

  billing_mode                = "PROVISIONED"
  deletion_protection_enabled = "false"
  hash_key                    = "ID"
  name                        = "WebsiteViewCounter"

  point_in_time_recovery {
    enabled = "false"
  }

  read_capacity  = "1"
  stream_enabled = "false"
  table_class    = "STANDARD"
  write_capacity = "1"
}
