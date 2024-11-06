terraform {
  backend "s3" {
    bucket         = "terraform-state-34435355"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    //dynamodb_table = "terraform-state-lock"
  }
}